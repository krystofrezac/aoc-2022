let run = async () => {
  let argv = NodeJs.Process.process->NodeJs.Process.argv
  switch argv {
  | [_node, _path, day] => {
      let input = await Input.readFromStdin()

      switch day {
      | "01_0" => Day01_0.run(input)
      | "01_1" => Day01_1.run(input)
      | _ => Console.log("Invalid day")
      }
    }
  | _ => Console.log("Invalid argv")
  }
}

run()->ignore
