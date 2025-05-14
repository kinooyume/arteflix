@schema
type tag = [#Ok]

@schema
type content = {
  tag: tag,
  value: ArteData.content,
}

@schema type player = {data: ArtePlayerConfig.t}
