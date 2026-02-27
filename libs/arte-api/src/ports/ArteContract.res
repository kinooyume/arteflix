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
