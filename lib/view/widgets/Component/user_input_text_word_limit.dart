import 'package:city_hub/resource/Theams/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInputTextWordLimit extends StatelessWidget {

  TextEditingController? textEditingControlleroller;

  FormFieldValidator<String>? validator;

  ValueChanged<String>? onChange;

  String? lableText;

  Widget? suffixIcon;

  Widget? prefixIcon;

  int? maxLine;

  int wordLimit;

  TextInputType? keybordType;

  bool obscureText;

  UserInputTextWordLimit({required this.textEditingControlleroller,
    required this.wordLimit,
    this.validator,
    this.onChange,
    required this.lableText,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLine=1,
    required this.keybordType,
    this.obscureText=false,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingControlleroller,
      validator: validator,
      onChanged: onChange,
      maxLines: maxLine,
      maxLength: wordLimit,
      keyboardType: keybordType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: lableText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: AppColors.error),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
