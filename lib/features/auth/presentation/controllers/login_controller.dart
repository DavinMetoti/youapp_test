import 'package:flutter/material.dart';

class LoginController {
  final username = TextEditingController();
  final password = TextEditingController();

  void dispose() {
    username.dispose();
    password.dispose();
  }
}
