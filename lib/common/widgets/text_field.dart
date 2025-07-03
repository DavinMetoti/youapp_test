import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';

class AppTextField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.inputHintColor),
        filled: true,
        fillColor: AppColors.inputFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.inputFocusedBorderColor, width: 2),
        ),
      ),
      style: TextStyle(color: AppColors.inputTextColor),
      keyboardType: keyboardType,
    );
  }

}