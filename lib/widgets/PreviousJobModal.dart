import 'package:flutter/material.dart';

class PreviousJobModal extends StatelessWidget {

  final TextEditingController title = TextEditingController();
  final TextEditingController companyName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: title,
          ),
          TextField(
            controller: companyName,
          )
        ],
      ),
    );
  }
}