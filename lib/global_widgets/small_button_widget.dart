// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SmallButton extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onTap;
  final Color containerColor;
  final Color borderColor;
  final TextStyle textStyle;
  const SmallButton(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.onTap,
      required this.textStyle,
      required this.containerColor,
      required this.borderColor});

  @override
  State<SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.containerColor,
          border: Border.all(color: widget.borderColor),
          borderRadius: BorderRadius.circular(5.0),
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
