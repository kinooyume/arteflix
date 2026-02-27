let extractProgramId = (item: ArteZoneContent.t, ~lang) =>
  item.programId->Option.getOr(
    item.id->String.slice(~start=0, ~end=-(String.length(lang) + 1)),
  )
