import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {

  final bool isPassword;
  final TextEditingController controller;

  LoginInput({this.isPassword = false, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: (value) {
        if (isPassword) {
          if (value.isEmpty) {
            return "Empty password is not allowed";
          }
          else if (value.length < 8) {
            return "Password must be greater than 8 characters long";
          }
        }
        else {
          if (value.isEmpty) {
            return "Empty email is not allowed";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: isPassword? Icon(Icons.security): Icon(Icons.mail),
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), 
          borderSide: BorderSide(width: 0, style: BorderStyle.none)
        ),
      ),
    );
  }
}