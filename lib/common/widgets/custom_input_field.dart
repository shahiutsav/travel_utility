import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.focusNode,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });
  final String labelText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLength: maxLengthEnforcement == MaxLengthEnforcement.enforced ? 160 : null,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 28,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 3,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 3,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 3,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 3,
            color: Colors.red.shade300,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
