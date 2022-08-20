import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pac_man/path.dart';
import 'package:pac_man/pixel.dart';
import 'package:pac_man/player.dart';
import 'package:pac_man/ghost.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 15 + 1;
  int ghost = numberInRow * 2 - 2;
  bool preGame = true;
  bool bocaFechada = false;
  int pontos = 0;

  List<int> barreiras = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    78,
    79,
    80,
    100,
    101,
    102,
    84,
    85,
    86,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    81,
    70,
    59,
    61,
    72,
    83,
    26,
    28,
    37,
    38,
    39,
    123,
    134,
    145,
    156,
    129,
    140,
    151,
    162,
    103,
    114,
    125,
    105,
    116,
    127,
    147,
    148,
    149,
    158,
    160
  ];
  List<int> food = [];
  String direction = "right";
  String ghostLast = "left";
  String ghostLast2 = "left";
  String ghostLast3 = "down";

  void startGame() {
    if (preGame) {
      preGame = false;
      getFood();
      Timer.periodic(Duration(milliseconds: 170), (timer) {
        moveGhost();
        //movimento da boca
        setState(() {
          bocaFechada = !bocaFechada;
        });

        //some as comidas
        if (food.contains(player)) {
          setState(() {
            food.remove(player);
          });
          pontos++;
        }
        if (player == ghost) {
          player = -1;
        }

        switch (direction) {
          case "left":
            moveLeft();
            break;

          case "right":
            moveRight();
            break;

          case "up":
            moveUp();
            break;

          case "down":
            moveDown();
            break;
        }
      });
    }
  }

//metodo de comer as bolinhas
  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barreiras.contains(i)) {
        food.add(i);
      }
    }
  }

//metedos de deteccao de movimento do jogador
  moveLeft() {
    if (!barreiras.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  moveRight() {
    if (!barreiras.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  moveUp() {
    if (!barreiras.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  moveDown() {
    if (!barreiras.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  void moveGhost() {
    switch (ghostLast) {
      case "left":
        if (!barreiras.contains(ghost - 1)) {
          setState(() {
            ghost--;
          });
        } else {
          if (!barreiras.contains(ghost + numberInRow)) {
            setState(() {
              ghost += numberInRow;
              ghostLast = "down";
            });
          } else if (!barreiras.contains(ghost + 1)) {
            setState(() {
              ghost++;
              ghostLast = "right";
            });
          } else if (!barreiras.contains(ghost - numberInRow)) {
            setState(() {
              ghost -= numberInRow;
              ghostLast = "up";
            });
          }
        }
        break;
      case "right":
        if (!barreiras.contains(ghost + 1)) {
          setState(() {
            ghost++;
          });
        } else {
          if (!barreiras.contains(ghost - numberInRow)) {
            setState(() {
              ghost -= numberInRow;
              ghostLast = "up";
            });
          } else if (!barreiras.contains(ghost + numberInRow)) {
            setState(() {
              ghost += numberInRow;
              ghostLast = "down";
            });
          } else if (!barreiras.contains(ghost - 1)) {
            setState(() {
              ghost--;
              ghostLast = "left";
            });
          }
        }
        break;
      case "up":
        if (!barreiras.contains(ghost - numberInRow)) {
          setState(() {
            ghost -= numberInRow;
            ghostLast = "up";
          });
        } else {
          if (!barreiras.contains(ghost + 1)) {
            setState(() {
              ghost++;
              ghostLast = "right";
            });
          } else if (!barreiras.contains(ghost - 1)) {
            setState(() {
              ghost--;
              ghostLast = "left";
            });
          } else if (!barreiras.contains(ghost + numberInRow)) {
            setState(() {
              ghost += numberInRow;
              ghostLast = "down";
            });
          }
        }
        break;
      case "down":
        if (!barreiras.contains(ghost + numberInRow)) {
          setState(() {
            ghost += numberInRow;
            ghostLast = "down";
          });
        } else {
          if (!barreiras.contains(ghost - 1)) {
            setState(() {
              ghost--;
              ghostLast = "left";
            });
          } else if (!barreiras.contains(ghost + 1)) {
            setState(() {
              ghost++;
              ghostLast = "right";
            });
          } else if (!barreiras.contains(ghost - numberInRow)) {
            setState(() {
              ghost -= numberInRow;
              ghostLast = "up";
            });
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: (MediaQuery.of(context).size.height.toInt() * 0.0139).toInt(),
            //detecta o movimento
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy < 0) {
                  direction = "up";
                } else if (details.delta.dy > 0) {
                  direction = "down";
                }
                //print(direction);
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
                //print(direction);
              },
              //deteccao de movimento ate linha de cima
              child: Container(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: numberOfSquares,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: numberInRow),
                      itemBuilder: (BuildContext context, int index) {
                        if (bocaFechada && player == index) {
                          return Padding(
                            padding: EdgeInsets.all(4),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 204, 0),
                                  shape: BoxShape.circle),
                            ),
                          );
                        } else if (player == index) {
                          switch (direction) {
                            case "left":
                              return Transform.rotate(
                                angle: pi,
                                child: MyPlayer(),
                              );
                              break;
                            case "right":
                              return MyPlayer();
                              break;
                            case "up":
                              return Transform.rotate(
                                  angle: 3 + pi / 2, child: MyPlayer());
                              break;
                            case "down":
                              return Transform.rotate(
                                  angle: pi / 2, child: MyPlayer());
                              break;
                            default:
                              return MyPlayer();
                          }
                        } else if (ghost == index) {
                          return MyGhost();
                        } else if (barreiras.contains(index)) {
                          return MyPixel(
                            innerColor: Colors.blue[900],
                            outerColor: Colors.blue[900],
                            //child: Text(index.toString()),
                          );
                        } else if (preGame || food.contains(index)) {
                          return MyPath(
                            innerColor: Colors.yellow,
                            outerColor: Colors.black,
                            // child: Text(index.toString()),
                          );
                        } else {
                          return MyPath(
                            innerColor: Colors.black,
                            outerColor: Colors.black,
                            //child: Text(index.toString()),
                          );
                        }
                      })),
            ),
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Score: " + pontos.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                GestureDetector(
                  onTap: startGame,
                  child: Text(
                    "P L A Y",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
