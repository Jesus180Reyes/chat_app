import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final Icon icon;
  final String placeHolder;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  const CustomInput({
    Key? key,
    required this.icon,
    required this.placeHolder,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        autocorrect: false,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: icon,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: placeHolder,
        ),
      ),
    );
  }
}
