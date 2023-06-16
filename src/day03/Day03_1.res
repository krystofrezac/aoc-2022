let run = input => {
  let backpacks = input->String.split("\n")
  let backpacksLength = Array.length(backpacks)
  let numberOfGroups = backpacksLength / 3

  let groups =
    Array.make(~length=numberOfGroups, 0)
    ->Array.mapWithIndex((_, groupIndex) => {
      let groupBackpacks =
        backpacks
        ->Array.slice(~start=groupIndex * 3, ~end=groupIndex * 3 + 3)
        ->Array.map(String.split(_, ""))
      switch groupBackpacks {
      | [first, second, third] => Some((first, second, third))
      | _ => None
      }
    })
    ->Array.keepSome

  let groupsCommonItem =
    groups
    ->Array.map(((firstBackpack, secondBackpack, thirdBackpack)) => {
      let firstBackpackSet = Set.fromArray(firstBackpack)
      let secondBackpackSet = Set.fromArray(secondBackpack)

      thirdBackpack->Array.find(item =>
        Set.has(firstBackpackSet, item) && Set.has(secondBackpackSet, item)
      )
    })
    ->Array.keepSome

  let groupsPriorities = groupsCommonItem->Array.map(Day03_Common.itemToPriority)->Array.keepSome

  let totalPriority = groupsPriorities->Array.reduce(0, (acc, priority) => acc + priority)

  Console.log(`> ${totalPriority->Int.toString}`)
}
