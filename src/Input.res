let readFromStdin = () => {
  open NodeJs

  let stdinString = ref("")

  Promise.make((resolve, _reject) =>
    Process.process
    ->Process.stdin
    ->Stream.onData(chunk =>
      stdinString := chunk->Buffer.toString->String.concat(stdinString.contents, _)
    )
    ->Stream.onEnd(() => stdinString.contents->resolve(. _))
    ->ignore
  )
}
