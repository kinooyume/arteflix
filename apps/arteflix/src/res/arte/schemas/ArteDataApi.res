@schema
type tag = [#Ok]

@schema
type content = {
  tag: tag,
  value: ArteData.t,
}

@schema type player = {data: ArtePlayerConfig.t}
