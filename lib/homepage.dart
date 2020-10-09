import 'dart:async';

import 'package:bomber_man/button.dart';
import 'package:bomber_man/pixel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 140;
  int playerPosition = 0;
  int bombPosition = -1;
  List<int> barriers = [
    11,
    13,
    15,
    17,
    18,
    31,
    32,
    34,
    36,
    38,
    51,
    53,
    55,
    57,
    58,
    71,
    72,
    74,
    76,
    78,
    91,
    92,
    95,
    97,
    98,
    111,
    113,
    115,
    118,
    121,
    123,
    125,
    127,
    128
  ];
  List<int> boxes = [
    21,
    12,
    23,
    33,
    25,
    16,
    28,
    42,
    52,
    54,
    46,
    47,
    61,
    63,
    65,
    67,
    82,
    84,
    85,
    88,
    102,
    103,
    105,
    107,
    108,
    116,
    124,
    122
  ];
  List<int> fire = [-1];

  void _moveUp() {
    setState(() {
      if (playerPosition - 10 >= 0 &&
          !barriers.contains(playerPosition - 10) &&
          !boxes.contains(playerPosition - 10)) {
        playerPosition -= 10;
      }
    });
  }

  void _moveLeft() {
    setState(() {
      if (!(playerPosition % 10 == 0) &&
          !barriers.contains(playerPosition - 1) &&
          !boxes.contains(playerPosition - 1)) {
        playerPosition -= 1;
      }
    });
  }

  void _moveRight() {
    setState(() {
      if (!(playerPosition % 10 == 9) &&
          !barriers.contains(playerPosition + 1) &&
          !boxes.contains(playerPosition + 1)) {
        playerPosition += 1;
      }
    });
  }

  void _moveDown() {
    setState(() {
      if (playerPosition + 10 < numberOfSquares &&
          !barriers.contains(playerPosition + 10)) {
        playerPosition += 10;
      }
    });
  }

  void _dropBomb() {
    setState(() {
      bombPosition = playerPosition;
      fire.clear();
      Timer(Duration(milliseconds: 1500), () {
        setState(() {
          fire.add(bombPosition);
          fire.add(bombPosition - 1);
          fire.add(bombPosition + 1);
          fire.add(bombPosition - 10);
          fire.add(bombPosition + 10);
        });
        clearFire();
      });
    });
  }

  void clearFire() {
    setState(() {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          for (int i = 0; i < fire.length; i++) {
            if (boxes.contains(fire[i])) {
              boxes.remove(fire[i]);
            }
          }
          fire.clear();
          bombPosition = -1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10),
                  itemBuilder: (BuildContext context, int index) {
                    if (fire.contains(index)) {
                      return MyPixel(
                        setInnerColor: Colors.red,
                        setOutColor: Colors.red[900],
                      );
                    } else if (bombPosition == index) {
                      return MyPixel(
                        setInnerColor: Colors.grey,
                        setOutColor: Colors.grey[900],
                        setChild: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset("lib/images/bomb.jpg"),
                        ),
                      );
                    } else if (playerPosition == index) {
                      return MyPixel(
                        setInnerColor: Colors.grey,
                        setOutColor: Colors.grey[900],
                        setChild: Image.asset("lib/images/bomberman.png"),
                      );
                    } else if (barriers.contains(index)) {
                      return MyPixel(
                        setInnerColor: Colors.black,
                        setOutColor: Colors.black12,
                        setChild: Text(index.toString()),
                      );
                    } else if (boxes.contains(index)) {
                      return MyPixel(
                        setInnerColor: Colors.brown,
                        setOutColor: Colors.brown[900],
                        setChild: Text(index.toString()),
                      );
                    } else
                      return MyPixel(
                        setInnerColor: Colors.grey,
                        setOutColor: Colors.grey[900],
                        setChild: Text(index.toString()),
                      );
                  }),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        setFunction: _moveUp,
                        setColorButton: Colors.blue,
                        setChild: Icon(
                          Icons.arrow_drop_up,
                          size: 50,
                        ),
                      ),
                      MyButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        setFunction: _moveLeft,
                        setColorButton: Colors.blue,
                        setChild: Icon(
                          Icons.arrow_left,
                          size: 50,
                        ),
                      ),
                      MyButton(
                        setFunction: _dropBomb,
                        setColorButton: Colors.white,
                        setChild: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset("lib/images/bomb.jpg"),
                        ),
                      ),
                      MyButton(
                        setFunction: _moveRight,
                        setColorButton: Colors.blue,
                        setChild: Icon(
                          Icons.arrow_right,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        setFunction: _moveDown,
                        setColorButton: Colors.blue,
                        setChild: Icon(
                          Icons.arrow_drop_down,
                          size: 50,
                        ),
                      ),
                      MyButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
