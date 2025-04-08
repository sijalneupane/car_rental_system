import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_system/widgets/custom_text.dart';

class CustomDropdown extends StatefulWidget {
  List<String> dropDownItemList;
  Function(String?)? onChanged;
  String? labelText;
  String? hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  CustomDropdown(
      {super.key,
      required this.dropDownItemList,
      this.onChanged,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.controller,
      this.validator});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            data: widget.labelText!,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField(
              dropdownColor: greyColor,
              focusNode: _focusNode,
              
              decoration: InputDecoration(
                
                contentPadding: const EdgeInsets.all(10),
                focusedBorder: const OutlineInputBorder(
                  
                  borderSide: BorderSide(width: 1, color: primaryColor),
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                labelText: widget.labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              items: widget.dropDownItemList
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: CustomText(
                        data: e,
                        color: Colors.black,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: widget.onChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator),
        ],
      ),
    );
  }
}
