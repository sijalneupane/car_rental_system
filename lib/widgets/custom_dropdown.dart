import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_system/widgets/custom_text.dart';

class CustomDropdown extends StatelessWidget {
  List<String> dropDownItemList;
  Function(String?)? onChanged;
  String? labelText;
  TextEditingController? controller;
  CustomDropdown(
      {super.key,
      required this.dropDownItemList,
      this.onChanged,
      this.labelText,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DropdownButtonFormField(
          dropdownColor: primaryColor,
          decoration: InputDecoration(
              labelText: labelText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          items: dropDownItemList
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: CustomText(
                    data: e,
                  )))
              .toList(),
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null) {
              return "$labelText cannot be empty";
            }
            return null;
          }),
    );
  }
}
