import 'package:flutter/material.dart';
import '../utils/ChatClipper.dart';

class ChatMessage extends StatelessWidget {

  final String message;
  final int index;

  ChatMessage({@required this.message, @required this.index});

  final Color chatColor = Colors.green.withAlpha(200);

  @override
  Widget build(BuildContext context) {
    final isEven = index%2 == 0;
    final radius = Radius.circular(5);
    final zeroRadius = Radius.circular(0);
    return Row(
      mainAxisAlignment: isEven? MainAxisAlignment.end: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (!isEven)
          ClipPath(
            clipper: ChatClipper(index: index),
            child: Container(
              width: 16,
              height: 16,
              color: chatColor
            ),
          )
        ,
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: isEven? radius: zeroRadius, bottomLeft: radius, bottomRight: radius, topRight: !isEven? radius: zeroRadius),
              color: chatColor
            ),
            padding: const EdgeInsets.all(10),
            child: Text(message)
          ),
        ),
        if (isEven)
          ClipPath(
            clipper: ChatClipper(index: index),
            child: Container(
              width: 16,
              height: 16,
              color: chatColor
            ),
          )
        ,
      ],
    );
  }
}