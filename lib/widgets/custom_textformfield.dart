import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  String? labelText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  String? Function(String?)? validator;
  CustomTextformfield({super.key,this.labelText,this.suffixIcon,this.prefixIcon,this.obscureText,this.keyboardType,this.controller,this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType:keyboardType ??TextInputType.text ,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        obscureText:obscureText??false ,
        decoration: InputDecoration(
          labelText:labelText ,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5)
          )
        ),
      ),
    );
  }
}