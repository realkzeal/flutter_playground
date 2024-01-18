import 'package:flutter/material.dart';
import 'package:rules/rules.dart';

class BTextField extends StatefulWidget {
  final TextEditingController textController;
  final IconData prefixIcon;
  final String? hint;
  final validator;
  bool isObscure;
  BTextField({
    super.key, required this.textController,
    required this.prefixIcon,  this.hint, this.validator, this.isObscure = false});

  @override
  State<BTextField> createState() => _BTextFieldState();

}

class _BTextFieldState extends State<BTextField> {
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.textController,
      decoration: InputDecoration(
        labelText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: Icon(widget.prefixIcon),
      ),
      obscureText: widget.isObscure ?? false,
      onChanged: (value) {
        // Handle text changes
      },
    );
  }
}
