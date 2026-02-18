type category = {
  code: string,
  text: string,
  href: string,
}

@module("./categories.json") external data: dict<array<category>> = "default"
