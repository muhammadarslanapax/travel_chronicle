import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

class SmallestTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController? textFieldController;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;

  const SmallestTextFieldWidget(
      {super.key,
      required this.hintText,
      this.textFieldController,
      this.readOnly = false,
      this.maxLines = 1,
      this.validator,
      required this.obscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap});

  @override
  State<SmallestTextFieldWidget> createState() =>
      _SmallestTextFieldWidgetState();
}

class _SmallestTextFieldWidgetState extends State<SmallestTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlign: TextAlign.center,
        maxLines: widget.maxLines,
        controller: widget.textFieldController,
        validator: widget.validator,
        obscureText: widget.obscureText,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        style: const TextStyle(
          color: textBrownColor,
        ),
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 15,
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: BorderSide(
              color: Colors.grey[500]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
