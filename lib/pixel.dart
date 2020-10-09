import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final setInnerColor;
  final setOutColor;
  final setChild;
  MyPixel({this.setInnerColor, this.setOutColor, this.setChild});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
            color: setOutColor,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: setInnerColor,
                  child: Center(
                    child: setChild,
                  ),
                ))),
      ),
    );
  }
}
