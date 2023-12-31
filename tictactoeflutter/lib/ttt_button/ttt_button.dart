import 'package:flutter/material.dart';

enum TTTButtonState {
  X,
  O,
  clear;
}

class TTTButton extends StatelessWidget {
  const TTTButton(
      {required this.onClick, this.state = TTTButtonState.clear, super.key});
  final VoidCallback onClick;
  final TTTButtonState state;
  @override
  Widget build(BuildContext context) {
    late final Widget child;
    switch (state) {
      case TTTButtonState.X:
        child = const Icon(Icons.close);
        break;
      case TTTButtonState.O:
        child = const Icon(
          Icons.radio_button_unchecked,
        );
        break;
      default:
        child = Container();
    }
    return GestureDetector(
        onTap: state == TTTButtonState.clear ? onClick : null,
        child: Card(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: child))));
  }
}
