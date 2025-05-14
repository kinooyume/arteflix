module Params = {
  type home = {lang: string}

  type category = {
    lang: string,
    category: string,
    title: option<string>,
  }
  type direct = {lang: string}

  type video = {
    lang: string,
    id: string,
    title?: string,
  }

  type collection = video

  type toStringData<'a> = 'a => promise<ArteData.t>
}

type home = Params.home => promise<ArteData.t>
type direct = Params.direct => promise<ArteData.t>
type video = Params.video => promise<ArteData.t>
type collection = Params.video => promise<ArteData.t>
type category = Params.category => promise<ArteData.t>

type t = {home: home, direct: direct, video: video, category: category}
