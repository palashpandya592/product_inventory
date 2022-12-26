import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textInputField extends StatelessWidget {
  textInputField({
    Key? key,
    this.icon,
    this.text,
    this.maxLength,
    this.suffixIcon,
    this.suffixIconColor,
    this.validator,
    this.controllers,
    this.isObscure = false,
    this.textColor,
    this.keyboardType,
    this.onChanged,
    this.labelText,
    this.onTap,
    this.onSaved,
    required this.readOnly,
  });
  final icon;
  final text;
  final labelText;
  final maxLength;
  final suffixIcon;
  final suffixIconColor;
  final validator;
  final controllers;
  final isObscure;
  final textColor;
  final keyboardType;
  final onChanged;
  final onSaved;
  final onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLength: maxLength,
      validator: validator,
      controller: controllers,
      onChanged: onChanged,
      obscureText: isObscure,
      onSaved: onSaved,
      readOnly: readOnly,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(),
          errorStyle: TextStyle(fontSize: 15),
          contentPadding: EdgeInsets.only(top: 10),
          hintText: text,
          labelText: labelText,
          suffixIcon: Icon(suffixIcon, color: suffixIconColor),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIconColor: Colors.black,
          prefixIcon: IconButton(
              onPressed: () {}, icon: Icon(icon, color: Colors.black))),
    );
  }
}
