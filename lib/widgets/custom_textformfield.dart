import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  String? labelText;
  String? hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  String? Function(String?)? validator;
  CustomTextformfield(
      {super.key,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText,
      this.keyboardType,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(data: labelText!,fontWeight: FontWeight.bold,fontSize: 16,),
          const SizedBox(height: 10), // Space between label and field
          TextFormField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
                // labelText: labelText,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                alignLabelWithHint: true,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ],
      ),
    );
  }
}
