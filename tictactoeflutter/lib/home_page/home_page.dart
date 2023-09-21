import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tictactoeflutter/ttt_button/ttt_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<TTTButtonState> states;
  late TTTButtonState turn;
  int remainingTurns=9;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    turn = TTTButtonState.X;
    states = List.generate(
      9,
      (index) => TTTButtonState.clear,
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text("Turn Of: ${turn.toString()}"),
          trailing: IconButton(
            icon: Icon(Icons.replay),
            onPressed: () => Navigator.of(context).pushReplacementNamed("/"),
          ),
        ),
        Expanded(
          child: Row(
              children: states
                  .sublist(0, 3)
                  .mapIndexed(
                    (index, element) => Expanded(
                      child: TTTButton(
                          onClick: () => onButtonClick(index),
                          state: states[index]),
                    ),
                  )
                  .toList()),
        ),
        Expanded(
          child: Row(
              children: states
                  .sublist(3, 6)
                  .mapIndexed(
                    (index, element) => Expanded(
                      child: TTTButton(
                          onClick: () => onButtonClick(index + 3),
                          state: states[index+3]),
                    ),
                  )
                  .toList()),
        ),
        Expanded(
          child: Row(
              children: states
                  .sublist(6, 9)
                  .mapIndexed(
                    (index, element) => Expanded(
                      child: TTTButton(
                          onClick: () => onButtonClick(index + 6),
                          state: states[index+6]),
                    ),
                  )
                  .toList()),
        ),
        // GridView(
        //   physics: NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   gridDelegate:
        //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        //   children: states
        //       .mapIndexed<Widget>(
        //         (index, element) => TTTButton(
        //             onClick: () => onButtonClick(index),
        //             state: states[index]),
        //       )
        //       .toList(),
        // ),
      ],
    );
  }

  void onButtonClick(int index) => setState(() {
        states[index] = turn;
        turn = turn == TTTButtonState.X ? TTTButtonState.O : TTTButtonState.X;
        var result = checkWinner();
        if (null != result) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text("Winner is: ${result.toString()}"),
            ),
          );
        }else if(--remainingTurns<=0){
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text("Draw"),
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
      TTTButtonState a = states[victory[0]];
      TTTButtonState b = states[victory[1]];
      TTTButtonState c = states[victory[2]];
      if (a != TTTButtonState.clear && a == b && b == c) {
        return a;
      }
    }
    return null;
  }
}
