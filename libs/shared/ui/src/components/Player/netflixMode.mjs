import videojs from "video.js";

const Plugin = videojs.getPlugin("plugin");

class NetflixMode extends Plugin {
  constructor(player, options = {}) {
    super(player, options);

    this._onKeyDown = this._onKeyDown.bind(this);
    this._onUserActive = this._onUserActive.bind(this);
    this._onUserInactive = this._onUserInactive.bind(this);

    player.options_.inactivityTimeout = options.inactivityTimeout ?? 3000;

    this._buildGradients();

    const bigPlay = player.getChild("bigPlayButton");
    if (bigPlay) bigPlay.hide();

    player.on("useractive", this._onUserActive);
    player.on("userinactive", this._onUserInactive);
    document.addEventListener("keydown", this._onKeyDown);
  }

  _buildGradients() {
    const shared =
      "position:absolute;left:0;right:0;pointer-events:none;transition:opacity .3s;z-index:1;";

    this._topGradient = document.createElement("div");
    this._topGradient.style.cssText = `${shared}top:0;height:120px;background:linear-gradient(to bottom,rgba(0,0,0,.7),transparent);`;

    this._bottomGradient = document.createElement("div");
    this._bottomGradient.style.cssText = `${shared}bottom:0;height:160px;background:linear-gradient(to top,rgba(0,0,0,.7),transparent);`;

    this.player.el().appendChild(this._topGradient);
    this.player.el().appendChild(this._bottomGradient);
  }

  _setGradientOpacity(value) {
    this._topGradient.style.opacity = value;
    this._bottomGradient.style.opacity = value;
  }

  _onUserActive() {
    this._setGradientOpacity("1");
    this.player.el().style.cursor = "";
  }

  _onUserInactive() {
    if (!this.player.paused()) {
      this._setGradientOpacity("0");
      this.player.el().style.cursor = "none";
    }
  }

  _onKeyDown(e) {
    const tag = e.target.tagName;
    if (tag === "INPUT" || tag === "TEXTAREA" || tag === "SELECT") return;
    if (e.altKey || e.ctrlKey || e.metaKey) return;

    const p = this.player;

    switch (e.key) {
      case " ":
      case "k":
        e.preventDefault();
        p.paused() ? p.play() : p.pause();
        break;
      case "m":
        p.muted(!p.muted());
        break;
      case "f":
        p.isFullscreen() ? p.exitFullscreen() : p.requestFullscreen();
        break;
      case "ArrowLeft":
        e.preventDefault();
        p.currentTime(Math.max(0, p.currentTime() - 10));
        break;
      case "ArrowRight":
        e.preventDefault();
        p.currentTime(Math.min(p.duration(), p.currentTime() + 10));
        break;
      case "ArrowUp":
        e.preventDefault();
        p.volume(Math.min(1, p.volume() + 0.1));
        break;
      case "ArrowDown":
        e.preventDefault();
        p.volume(Math.max(0, p.volume() - 0.1));
        break;
    }
  }

  dispose() {
    document.removeEventListener("keydown", this._onKeyDown);

    if (this._topGradient?.parentNode) {
      this._topGradient.parentNode.removeChild(this._topGradient);
    }
    if (this._bottomGradient?.parentNode) {
      this._bottomGradient.parentNode.removeChild(this._bottomGradient);
    }

    this.player.el().style.cursor = "";

    super.dispose();
  }
}

videojs.registerPlugin("netflixMode", NetflixMode);
