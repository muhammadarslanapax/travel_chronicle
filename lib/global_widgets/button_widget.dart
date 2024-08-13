// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

class BigButton extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onTap;
  final TextStyle textStyle;
  const BigButton(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.onTap,
      required this.textStyle});

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: yellowColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}
