import 'package:flutter/material.dart';
import 'package:taskee/ui/helpers/helpers.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final String semanticsLabel;
  final String? Function(String?) validator;
  final Widget? suffixIcon;

  const CustomTextFieldWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.inputType,
    required this.obscureText,
    required this.semanticsLabel,
    required this.validator,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: TextFormField(
        keyboardType: inputType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: accentColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
          ),
        ),
      ),
    );
  }
}
