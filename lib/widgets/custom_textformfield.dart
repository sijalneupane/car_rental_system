import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextformfield extends StatefulWidget {
  String? labelText;
  String? hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function()? onTap;
  void Function(String)? onChanged;
  bool? readOnly;
  CustomTextformfield(
      {super.key,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText,
      this.keyboardType,
      this.controller,
      this.validator,
      this.onTap,
      this.readOnly,
      this.onChanged});

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            data: widget.labelText ?? "",
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 4), // Space between label and field
          TextFormField(
            onChanged:widget.onChanged ,
            focusNode: _focusNode,
            controller: widget.controller,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            onTap:widget.onTap,
            obscureText: widget.obscureText ?? false,
            readOnly:widget.readOnly??false,
            decoration: InputDecoration(
              errorMaxLines: 3,
              contentPadding:const EdgeInsets.all(10,) ,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: primaryColor)),
              // labelText: labelText,
              hintText: widget.hintText,
              hintStyle:const TextStyle(color: greyColor),
              alignLabelWithHint: true,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
