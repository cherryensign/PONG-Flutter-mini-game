import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  final leftmove;
  final rightmove;
  final pauseopen;

  CButton({this.leftmove, this.rightmove, this.pauseopen});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //right tap
      Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: rightmove,
          child: Container(
            alignment: Alignment.centerRight,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),
      //left tap
      Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: leftmove,
          child: Container(
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),

      Container(
        alignment: Alignment(0, 0.95),
        child: IconButton(
          onPressed: pauseopen,
          icon: Icon(Icons.pause_circle_filled, color: Colors.white),
          iconSize: 50,
        ),
      ),
    ]);
  }
}
