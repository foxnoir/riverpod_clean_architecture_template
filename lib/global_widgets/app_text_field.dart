import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.readOnly = false,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      readOnly: readOnly,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
    );
  }
}
