import 'package:flutter/material.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';

class CenteredTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController? textFieldController;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final int maxlines;

  const CenteredTextFieldWidget(
      {super.key,
      required this.hintText,
      this.textFieldController,
      this.maxlines = 1,
      this.validator,
      required this.obscureText,
      this.suffixIcon,
      this.prefixIcon});

  @override
  State<CenteredTextFieldWidget> createState() =>
      _CenteredTextFieldWidgetState();
}

class _CenteredTextFieldWidgetState extends State<CenteredTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxlines,
      controller: widget.textFieldController,
      validator: widget.validator,
      obscureText: widget.obscureText,
      style: const TextStyle(
        color: textBrownColor,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
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
