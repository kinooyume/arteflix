let setup: (VideoJs.t, string) => unit = %raw(`
  function(player, manifestUrl) {
    var tooltip = null;
    var thumbImg = null;
    var timeLabel = null;
    var cues = [];
    var sheetSizes = {};
    var progressHolder = null;

    function baseUrl(url) {
      return url.substring(0, url.lastIndexOf('/') + 1);
    }

    function parseTimestamp(ts) {
      var p = ts.split(':');
      return (+p[0]) * 3600 + (+p[1]) * 60 + parseFloat(p[2]);
    }

    function formatTime(seconds) {
      var h = Math.floor(seconds / 3600);
      var m = Math.floor((seconds % 3600) / 60);
      var s = Math.floor(seconds % 60);
      var mm = m < 10 ? '0' + m : '' + m;
      var ss = s < 10 ? '0' + s : '' + s;
      return h > 0 ? h + ':' + mm + ':' + ss : m + ':' + ss;
    }

    function parseCue(block, vttBase) {
      var lines = block.trim().split(/\r?\n/);
      if (lines.length < 2) return null;
      var times = lines[0].split(' --> ');
      if (times.length < 2) return null;
      var parts = lines[lines.length - 1].trim().split('#xywh=');
      if (parts.length < 2) return null;
      var coords = parts[1].split(',').map(Number);
      return {
        start: parseTimestamp(times[0].trim()),
        end: parseTimestamp(times[1].trim()),
        url: vttBase + parts[0],
        x: coords[0], y: coords[1], w: coords[2], h: coords[3]
      };
    }

    function findCue(time) {
      for (var i = 0; i < cues.length; i++) {
        if (time >= cues[i].start && time < cues[i].end) return cues[i];
      }
      return null;
    }

    var THUMB_W = 160;
    var THUMB_H = 90;

    player.ready(function() {
      var playerEl = player.el();
      progressHolder = playerEl.querySelector('.vjs-progress-holder');
      if (!progressHolder) return;

      tooltip = document.createElement('div');
      tooltip.className = 'vjs-sprite-thumbnail';

      thumbImg = document.createElement('div');
      thumbImg.className = 'vjs-sprite-thumbnail-img';
      thumbImg.style.width = THUMB_W + 'px';
      thumbImg.style.height = THUMB_H + 'px';
      thumbImg.style.display = 'none';
      tooltip.appendChild(thumbImg);

      timeLabel = document.createElement('div');
      timeLabel.className = 'vjs-sprite-thumbnail-time';
      tooltip.appendChild(timeLabel);

      progressHolder.appendChild(tooltip);
      progressHolder.addEventListener('mousemove', onMove);
      progressHolder.addEventListener('mouseleave', onLeave);

      player.on('dispose', function() {
        if (tooltip && tooltip.parentNode) tooltip.parentNode.removeChild(tooltip);
        if (progressHolder) {
          progressHolder.removeEventListener('mousemove', onMove);
          progressHolder.removeEventListener('mouseleave', onLeave);
        }
      });
    });

    fetch(manifestUrl).then(function(r) { return r.text(); }).then(function(manifest) {
      var match = manifest.match(/#SPRITES:\s*(.+)$/m);
      if (!match) return;
      var vttUrl = match[1].trim();
      if (!/^https?:\/\//.test(vttUrl)) vttUrl = baseUrl(manifestUrl) + vttUrl;
      var vttBase = baseUrl(vttUrl);

      return fetch(vttUrl).then(function(r) { return r.text(); }).then(function(vtt) {
        var blocks = vtt.split(/\r?\n\r?\n/);
        for (var i = 0; i < blocks.length; i++) {
          var cue = parseCue(blocks[i], vttBase);
          if (cue) {
            cues.push(cue);
            var right = cue.x + cue.w;
            var bottom = cue.y + cue.h;
            var s = sheetSizes[cue.url];
            if (!s) sheetSizes[cue.url] = { w: right, h: bottom };
            else {
              if (right > s.w) s.w = right;
              if (bottom > s.h) s.h = bottom;
            }
          }
        }
      });
    }).catch(function(e) { console.warn('[sprites]', e); });

    function onMove(e) {
      if (!tooltip) return;
      var rect = this.getBoundingClientRect();
      var ratio = Math.max(0, Math.min(1, (e.clientX - rect.left) / rect.width));
      var time = ratio * player.duration();

      timeLabel.textContent = formatTime(time);

      var cue = findCue(time);
      if (cue && thumbImg) {
        var scaleX = THUMB_W / cue.w;
        var scaleY = THUMB_H / cue.h;
        var sheet = sheetSizes[cue.url];
        thumbImg.style.backgroundImage = 'url(' + cue.url + ')';
        thumbImg.style.backgroundPosition = (-cue.x * scaleX) + 'px ' + (-cue.y * scaleY) + 'px';
        thumbImg.style.backgroundSize = (sheet.w * scaleX) + 'px ' + (sheet.h * scaleY) + 'px';
        thumbImg.style.display = 'block';
        tooltip.style.width = THUMB_W + 'px';
      } else if (thumbImg) {
        thumbImg.style.display = 'none';
        tooltip.style.width = 'auto';
      }

      var tooltipW = tooltip.offsetWidth;
      var left = e.clientX - rect.left - tooltipW / 2;
      left = Math.max(0, Math.min(left, rect.width - tooltipW));
      tooltip.style.left = left + 'px';
      tooltip.style.display = 'block';
    }

    function onLeave() {
      if (tooltip) tooltip.style.display = 'none';
    }
  }
`)
