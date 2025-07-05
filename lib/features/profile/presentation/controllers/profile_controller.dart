import 'package:flutter/material.dart';

class ProfileController {
  final name = TextEditingController();
  final birthday = ValueNotifier<DateTime?>(null);
  final height = TextEditingController();
  final weight = TextEditingController();

  void dispose() {
    name.dispose();
    height.dispose();
    weight.dispose();
    birthday.dispose();
  }
}
