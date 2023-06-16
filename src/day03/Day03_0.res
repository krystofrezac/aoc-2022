let run = input => {
  let backpacks = input->String.split("\n")

  let backpacksPriorities =
    backpacks
    ->Array.map(backpack => {
      let items = backpack->String.split("")
      let itemsLength = Array.length(items)
      let halfIndex = itemsLength / 2

      let firstHalf = items->Array.slice(~start=0, ~end=halfIndex)
      let secondHalf = items->Array.slice(~start=halfIndex, ~end=itemsLength)

      let firstHalfSet = Set.fromArray(firstHalf)

      let commonItemOption = secondHalf->Array.find(item => firstHalfSet->Set.has(item))
      switch commonItemOption {
      | Some(commonItem) => Day03_Common.itemToPriority(commonItem)
      | None => None
      }
    })
    ->Array.keepSome

  let prioritesSum = backpacksPriorities->Array.reduce(0, (acc, priority) => acc + priority)
  Console.log(`> ${prioritesSum->Int.toString}`)
}
