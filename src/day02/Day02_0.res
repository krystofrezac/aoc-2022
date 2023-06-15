module Move = {
  type t = Rock | Paper | Scissors

  let fromOponentInput = oponentMoveInput => {
    switch oponentMoveInput {
    | "A" => Some(Rock)
    | "B" => Some(Paper)
    | "C" => Some(Scissors)
    | _ => None
    }
  }

  let fromMyInput = myMoveInput =>
    switch myMoveInput {
    | "X" => Some(Rock)
    | "Y" => Some(Paper)
    | "Z" => Some(Scissors)
    | _ => None
    }

  let toScore = move => {
    switch move {
    | Rock => 1
    | Paper => 2
    | Scissors => 3
    }
  }
}

type round = {oponentMove: Move.t, myMove: Move.t}

module Outcome = {
  type t = Win | Loss | Draw

  let fromRound = (round: round) =>
    switch round {
    | {myMove, oponentMove} if myMove == oponentMove => Draw
    | {myMove: Rock, oponentMove: Scissors} => Win
    | {myMove: Scissors, oponentMove: Paper} => Win
    | {myMove: Paper, oponentMove: Rock} => Win
    | _ => Loss
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
      let myMoveOption =
        roundInput
        ->String.match(
          // Last character
          %re("/.$/"),
        )
        ->Option.map(RegExp.Result.fullMatch)
        ->Option.flatMap(Move.fromMyInput)

      switch (oponentMoveOption, myMoveOption) {
      | (Some(oponentMove), Some(myMove)) => Some({oponentMove, myMove})
      | _ => None
      }
    })
    ->Array.keepSome

  let endScore = rounds->Array.reduce(0, (acc, round) => {
    let outocomeScore = round->Outcome.fromRound->Outcome.toScore
    let moveScore = round.myMove->Move.toScore
    let roundScore = outocomeScore + moveScore

    acc + roundScore
  })
  Console.log(`> ${endScore->Int.toString}`)
}
