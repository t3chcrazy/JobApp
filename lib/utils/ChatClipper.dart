import 'package:flutter/material.dart';

class ChatClipper extends CustomClipper<Path> {

  final int index;

  ChatClipper({this.index});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;
    if (index%2 == 0) {
      path.moveTo(width, 0);
      path.lineTo(0, height);
      path.lineTo(0, 0);
      path.close();
    }
    else {
      path.lineTo(width, height);
      path.lineTo(width, 0);
      path.close();
    }
    return path;
  }
  
  @override
  bool shouldReclip(ChatClipper oldClipper) => false;

}