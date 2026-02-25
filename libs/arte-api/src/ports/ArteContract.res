module Params = {
  type home = {lang: string}

  type live = {lang: string}

  type program = {
    lang: string,
    id: string,
    title?: string,
  }

  type collection = program
  type category = {lang: string, slug: string}
  type categoryPage = {lang: string, slug: array<string>}

  type player = {id: string, lang: string}
}

type home = Params.home => promise<ArteData.t>
type live = Params.live => promise<ArteData.t>

type program = Params.program => promise<ArteData.t>
type collection = Params.program => promise<ArteData.t>

type category = Params.category => promise<ArteData.t>

type player = Params.player => promise<ArtePlayerConfig.t>
