import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("We are looking to hire an experienced Principal Software Engineer to maintain and upgrade all existing software. The Principal Software Engineer’s responsibilities include recommending adjustments to resolve software issues, improving the functionality of existing software, and ensuring that the design, application, and maintenance of software meets the quality standards of the company. You should also be able to mentor, guide and train other engineers."),
        SizedBox(height: 20),
        Text("To be successful as a Principal Software Engineer, you should be able to evaluate the user’s needs, time limitations and system limitations when developing software. A stand-out Principal Software Engineer is one who is up to date on new technologies and software development practices."),
      ],
    );
  }
}