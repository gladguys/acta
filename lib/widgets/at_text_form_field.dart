import 'package:flutter/material.dart';

class ATTextFormField extends StatelessWidget {
  ATTextFormField({
    @required this.hintText,
    this.prefixIcon,
    this.textInputType,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onSaved,
    this.validator,
    this.onEditingComplete,
    this.isRequired = false,
  });

  final String hintText;
  final IconData prefixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSaved;
  final Function validator;
  final Function onEditingComplete;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.brown[800]),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Colors.brown[800],),
        hintText: '$hintText ${isRequired ? ' *' : ''}',
        hintStyle: TextStyle(color: Colors.brown[800]),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.brown[800]),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.brown[800], width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[200]),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[200], width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: obscureText,
      focusNode: focusNode,
      onSaved: onSaved,
      validator: validator,
      onEditingComplete: onEditingComplete,
    );
  }
}