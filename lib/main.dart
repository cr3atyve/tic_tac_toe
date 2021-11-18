import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  bool oTurn = true;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  static var myFont = GoogleFonts.shareTechMono(textStyle: const TextStyle(color: Colors.black, letterSpacing: 3));
  static var myFontWhite =
      GoogleFonts.shareTechMono(textStyle: const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 25));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X',
                          style: myFontWhite,
                        ),
                        Text(
                          xScore.toString(),
                          style: myFontWhite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player 0',
                          style: myFontWhite,
                        ),
                        Text(
                          oScore.toString(),
                          style: myFontWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: myFont,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'TIC TAC TOE',
                    style: myFontWhite,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = '0';
        filledBoxes += 1;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBoxes += 1;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXO[0] == displayXO[1] && displayXO[0] == displayXO[2] && displayXO[0] != '') {
      _showWinDialog(displayXO[0]);
    }

    if (displayXO[3] == displayXO[4] && displayXO[3] == displayXO[5] && displayXO[3] != '') {
      _showWinDialog(displayXO[3]);
    }

    if (displayXO[6] == displayXO[7] && displayXO[6] == displayXO[8] && displayXO[6] != '') {
      _showWinDialog(displayXO[6]);
    }

    if (displayXO[0] == displayXO[3] && displayXO[0] == displayXO[6] && displayXO[0] != '') {
      _showWinDialog(displayXO[0]);
    }

    if (displayXO[1] == displayXO[4] && displayXO[1] == displayXO[7] && displayXO[1] != '') {
      _showWinDialog(displayXO[1]);
    }

    if (displayXO[2] == displayXO[5] && displayXO[2] == displayXO[8] && displayXO[2] != '') {
      _showWinDialog(displayXO[2]);
    }

    if (displayXO[6] == displayXO[4] && displayXO[6] == displayXO[2] && displayXO[6] != '') {
      _showWinDialog(displayXO[6]);
    }

    if (displayXO[0] == displayXO[4] && displayXO[0] == displayXO[8] && displayXO[0] != '') {
      _showWinDialog(displayXO[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Draw'),
            actions: <Widget>[
              TextButton(
                  child: const Text('Play again!'),
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner is: ' + winner),
            actions: <Widget>[
              TextButton(
                  child: const Text('Play again!'),
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });

    if (winner == '0') {
      oScore += 1;
    } else if (winner == 'X') {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
