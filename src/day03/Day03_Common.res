let itemToPriority = item => {
  let smallStartCode = Char.code('a')
  let bigStartCode = Char.code('A')

  let itemCodeOption = String.codePointAt(item, 0)
  switch itemCodeOption {
  | Some(itemCode) if itemCode >= smallStartCode =>
    (itemCode - smallStartCode + 1)->Some
  | Some(commontItemCode) => (commontItemCode - bigStartCode + 27)->Some
  | None => None
  }
}
