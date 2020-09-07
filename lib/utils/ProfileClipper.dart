import 'package:flutter/material.dart';

class ProfileClipper extends CustomClipper<Path> {

  final double radius = 50.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double width = size.width;
    final double height = size.height;
    path.lineTo(0, height-radius);
    path.arcToPoint(Offset(radius, height), radius: Radius.circular(radius), clockwise: false);
    path.lineTo(width-radius, height);
    path.arcToPoint(Offset(width, height-radius), radius: Radius.circular(radius), clockwise: false);
    path.lineTo(width, 0);
    path.close();
    return path;
  }
  
  @override
  bool shouldReclip(ProfileClipper oldClipper) => false;
  
}