import 'package:flutter/material.dart';

class getTextFormField extends StatefulWidget {
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;
  bool isEnable;

  getTextFormField(
      {Key? key,
      required this.controller,
      required this.hintName,
      required this.icon,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.isEnable = true})
      : super(key: key);

  @override
  State<getTextFormField> createState() => _getTextFormFieldState();
}

class _getTextFormFieldState extends State<getTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isObscureText,
        enabled: widget.isEnable,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(widget.icon),
          hintText: widget.hintName,
          labelText: widget.hintName,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}
