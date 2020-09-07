import 'dart:math';

import 'package:flutter/material.dart';
import '../models/PreviousJob.dart';

class PreviousJobCard extends StatefulWidget {

  final PreviousJob pJob;

  PreviousJobCard({this.pJob});

  @override
  _PreviousJobCardState createState() => _PreviousJobCardState();
}

class _PreviousJobCardState extends State<PreviousJobCard> with SingleTickerProviderStateMixin {

  AnimationController _expandController;
  Animation _height;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100)
    );
    _height = Tween(begin: 100.0, end: 200.0).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: Curves.fastLinearToSlowEaseIn,
      )
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _expandController.isCompleted? _expandController.reverse(): _expandController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final previousJob = widget.pJob;
    return AnimatedBuilder(
      animation: _expandController,
      builder: (context, child) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: _height.value,
        decoration: BoxDecoration(
          color: Color(0xFFf5f6fa),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0,0),
            blurRadius: 6,
            spreadRadius: 0
          )]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 100.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(previousJob.job.jobTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                        Transform(
                          origin: Offset(12, 12),
                          transform: Matrix4.rotationZ(((_height.value-100.0)/100)*pi),
                          child: GestureDetector(
                            child: Icon(Icons.keyboard_arrow_down),
                            onTap: _handleTap,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(previousJob.job.jobCompany.companyName)
                  ],
                )
              )
            ),
            SizedBox(
              height: 100.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Responsibilites", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    ...previousJob.responsibilities.map((e) => Text(e, style: TextStyle(fontSize: 12)))
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}