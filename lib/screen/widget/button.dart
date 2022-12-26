import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buttons extends StatefulWidget {
  const buttons({
    Key? key,
    required this.buttonName,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.fontSize,
    required this.onTap,
  }) : super(key: key);
  final buttonName;
  final buttonHeight;
  final buttonWidth;
  final fontSize;
  final VoidCallback onTap;

  @override
  State<buttons> createState() => _buttonsState();
}

class _buttonsState extends State<buttons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.buttonWidth,
        height: widget.buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal.shade400),
        child: Text(
          widget.buttonName,
          style: TextStyle(
              color: Colors.white,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
