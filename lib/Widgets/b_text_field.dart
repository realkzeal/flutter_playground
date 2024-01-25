import 'package:flutter/material.dart';

class BTextField extends StatefulWidget {
  final TextEditingController textController;
  final IconData prefixIcon;
  final String? hint;
  bool isObscure;
  final bool isPassword;
  final Function(String value)? onChanged;
  final FocusNode? focusNode;
  Widget? suffixIcon;

  BTextField(
      {Key? key,
      required this.textController,
      required this.prefixIcon,
      this.hint,
      this.isObscure = false,
      this.onChanged,
      this.focusNode,
      this.isPassword = false,
      this.suffixIcon})
      : super(key: key);

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
        suffixIcon: widget.isPassword
            ? GestureDetector(
                child: Icon(
                  widget.isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey[600],
                ),
                onTap: () {
                  setState(() {
                    widget.isObscure = !widget.isObscure;
                  });
                },
              )
            : widget.suffixIcon,
      ),
      obscureText: widget.isObscure,
      onChanged: widget.onChanged,
      // Set labelText only when the field is not focused
      // This provides a better user experience
      // by showing the hint as a label when the user starts typing
      // and the field is not focused.
      focusNode: widget.focusNode,
    );
  }
}
