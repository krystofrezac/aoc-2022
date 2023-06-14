let run = input => {
  let elfsCalories = input->String.split("\n\n")
  let caloriesPerElf = elfsCalories->Array.map(elfCalories => {
    elfCalories
    ->String.split("\n")
    ->Array.map(calory => Int.fromString(calory))
    ->Array.keepSome
    ->Array.reduce(0, (acc, current) => acc + current)
  })
  let elfsWithMaxCalories = caloriesPerElf->Array.reduce((0, 0, 0), (acc, current) => {
    let (firstElf, secondElf, thirdElf) = acc

    switch (current > firstElf, current > secondElf, current > thirdElf) {
    | (true, _, _) => (current, firstElf, secondElf)
    | (false, true, _) => (firstElf, current, secondElf)
    | (false, false, true) => (firstElf, secondElf, current)
    | _ => acc
    }
  })
  let totalCalories = {
    let (firstElf, secondElf, thirdElf) = elfsWithMaxCalories
    firstElf + secondElf + thirdElf
  }
  Console.log(`> ${totalCalories->Int.toString}`)
}
