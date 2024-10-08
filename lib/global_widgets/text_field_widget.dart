import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController? textFieldController;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final int maxLines;
  final int? maxCharacters;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;

  const TextFieldWidget(
      {super.key,
      required this.hintText,
      this.textFieldController,
      this.readOnly = false,
      this.maxLines = 1,
      this.validator,
      this.maxCharacters,
      required this.obscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.textInputAction,
      this.onTap});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction, // Moves focus to next.

      maxLines: widget.maxLines,
      maxLength: widget.maxCharacters,
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
          horizontal: 15,
          vertical: 15,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        hintText: widget.hintText,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey[500]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}
