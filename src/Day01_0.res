let run = input => {
  let elfsCalories = input->String.split("\n\n")
  let caloriesPerElf = elfsCalories->Array.map(elfCalories => {
    elfCalories
    ->String.split("\n")
    ->Array.map(calory => Int.fromString(calory))
    ->Array.keepSome
    ->Array.reduce(0, (acc, current) => acc + current)
  })
  let maxCalories = caloriesPerElf->Array.reduce(0, (acc, current) => {
    switch current > acc {
    | true => current
    | false => acc
    }
  })
  Console.log(`> ${maxCalories->Int.toString}`)
}
