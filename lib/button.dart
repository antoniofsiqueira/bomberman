import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final setFunction;
  final setColorButton;
  final setChild;

  MyButton({this.setFunction, this.setColorButton, this.setChild});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: setFunction,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: setColorButton,
            height: 50,
            width: 50,
            child: Center(
              child: setChild,
            ),
          ),
        ),
      ),
    );
  }
}
