# What is Laxe?
Laxe is a programming langauge that is read and run using [Haxe](https://haxe.org). Using Haxe's powerful compile-time capabilities, Laxe's source files are read and compiled into Haxe AST. The rest is handled by Haxe's compiler! Since Laxe is compiled to be valid Haxe, it is 100% interoperable with Haxe projects. Source files from both Haxe and Laxe can be mixed without much issue.

Essentially, Laxe is an alternative syntax for Haxe. It's based on Python's syntax and tries to be short, concise, and maybe a bit crazy. Below is the Laxe equivalent of the code shown on [haxe.org](https://haxe.org). 

```haxe
def main:
  var playerA = { name: "Simon", move: Paper }
  var playerB = { name: "Nicolas", move: Rock }

  var result = switch [playerA.move, playerB.move]:
    case [Rock, Scissors] |
         [Paper, Rock] |
         [Scissors, Paper]: Winner(playerA)

    case [Rock, Paper] |
         [Paper, Scissors] |
         [Scissors, Rock]: Winner(playerB)

    case _: Draw

  trace('result: $result')

alias type Player = { name: str, move: Move }

enum Move:
  Rock; Paper; Scissors

enum Result:
  Winner(Player)
  Draw
```

[NEXT >>](https://github.com/RobertBorghese/laxe/blob/main/documentation/2_NewSyntax/2_1_Comments.md)
