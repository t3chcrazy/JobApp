import 'package:flutter/material.dart';

class CustomCurve extends CustomClipper<Path> {

  final double heightFactor = 0.6;

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double width = size.width;
    final double height = size.height;
    path.lineTo(0, heightFactor*height);
    path.quadraticBezierTo(width/2, height, width, heightFactor*height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
  
}