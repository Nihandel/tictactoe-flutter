import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tictactoeflutter/ttt_button/ttt_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<List<TTTButtonState>> states;
  late TTTButtonState turn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    turn = TTTButtonState.X;
    states = List.generate(
        3,
        (index) => List<TTTButtonState>.generate(
              3,
              (index) => TTTButtonState.clear,
            ));
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
            title: Text("Turn Of: ${turn.toString()}"),
            trailing: IconButton(
              icon: Icon(Icons.replay),
              onPressed: () => Navigator.of(context).pushReplacementNamed("/"),
            )),
        Expanded(
          child: Table(
            border: TableBorder.all(color: Colors.red, width: 1),
            children: states
                .mapIndexed(
                  (rowIndex, row) => TableRow(
                    children: row
                        .mapIndexed(
                          (index, state) => TTTButton(
                            onClick: () => onButtonClick(rowIndex, index),
                            state: state,
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  void onButtonClick(int row, int col) => setState(() {
        states[row][col] = turn;
        turn = turn == TTTButtonState.X ? TTTButtonState.O : TTTButtonState.X;
        var result = checkWinner();
        if (null != result) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text("Winner is: ${result.toString()}"),
            ),
          );
        }
      });
  TTTButtonState? checkWinner() {
    List<List<int>> victoryConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (int i = 0; i < victoryConditions.length; i++) {
      var victory = victoryConditions[i];
      TTTButtonState a = states[victory[0] ~/ 3][(victory[0] % 3)];
      TTTButtonState b = states[victory[1] ~/ 3][(victory[1] % 3)];
      TTTButtonState c = states[victory[2] ~/ 3][(victory[2] % 3)];
      if (a != TTTButtonState.clear && a == b && b == c) {
        return a;
      }
    }
    return null;
  }
}
