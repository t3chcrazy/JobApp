import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {

  final IconData icon;
  final int value;
  final String metric;

  ProfileTab({this.icon, this.value, this.metric});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              SizedBox(width: 2),
              Text(value.toString())
            ],
          ),
          Text(metric)
        ],
      ),
    );
  }
}