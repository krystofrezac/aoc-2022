type move = Rock | Paper | Scissors
type outcome = Win | Loss | Draw
type round = {oponentMove: move, expectedOutcome: outcome}

module Move = {
  type t = move

  let fromOponentInput = oponentMoveInput => {
    switch oponentMoveInput {
    | "A" => Some(Rock)
    | "B" => Some(Paper)
    | "C" => Some(Scissors)
    | _ => None
    }
  }

  let toScore = move => {
    switch move {
    | Rock => 1
    | Paper => 2
    | Scissors => 3
    }
  }

  let fromRound = round => {
    switch round {
    | {expectedOutcome: Win, oponentMove: Paper} => Scissors
    | {expectedOutcome: Win, oponentMove: Scissors} => Rock
    | {expectedOutcome: Win, oponentMove: Rock} => Paper
    | {expectedOutcome: Loss, oponentMove: Paper} => Rock
    | {expectedOutcome: Loss, oponentMove: Scissors} => Paper
    | {expectedOutcome: Loss, oponentMove: Rock} => Scissors
    | {expectedOutcome: Draw, oponentMove} => oponentMove
    }
  }
}

module Outcome = {
  type t = outcome

  let fromOutcomeInput = outcomeInput =>
    switch outcomeInput {
    | "X" => Some(Loss)
    | "Y" => Some(Draw)
    | "Z" => Some(Win)
    | _ => None
    }

  let toScore = outcome => {
    switch outcome {
    | Win => 6
    | Draw => 3
    | Loss => 0
    }
  }
}

let run = input => {
  let rounds =
    input
    ->String.split("\n")
    ->Array.map(roundInput => {
      let oponentMoveOption =
        roundInput
        ->String.match(
          // First character
          %re("/^./"),
        )
        ->Option.map(RegExp.Result.fullMatch)
        ->Option.flatMap(Move.fromOponentInput)
      let expectedOutcomeOption =
        roundInput
        ->String.match(
          // Last character
          %re("/.$/"),
        )
        ->Option.map(RegExp.Result.fullMatch)
        ->Option.flatMap(Outcome.fromOutcomeInput)

      switch (oponentMoveOption, expectedOutcomeOption) {
      | (Some(oponentMove), Some(expectedOutcome)) => Some({oponentMove, expectedOutcome})
      | _ => None
      }
    })
    ->Array.keepSome

  let endScore = rounds->Array.reduce(0, (acc, round) => {
    let outcomeScore = round.expectedOutcome->Outcome.toScore
    let moveScore = round->Move.fromRound->Move.toScore
    let roundScore = outcomeScore + moveScore

    Console.log(`${outcomeScore->Int.toString} + ${moveScore->Int.toString} = ${roundScore->Int.toString}`)

    acc + roundScore
  })
  Console.log(`> ${endScore->Int.toString}`)
}
