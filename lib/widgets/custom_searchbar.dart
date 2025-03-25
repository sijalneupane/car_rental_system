import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

class CustomSearchbar extends StatefulWidget {
  String? hintText;
  CustomSearchbar({super.key, this.hintText});

  @override
  State<CustomSearchbar> createState() => _CustomSearchbarState();
}

class _CustomSearchbarState extends State<CustomSearchbar> {
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: CustomIcons(icon: Icons.search),
          contentPadding: const EdgeInsets.all(8),
          focusedBorder: const OutlineInputBorder(
            
              borderSide: BorderSide(width: 1, color: primaryColor)),
          hintStyle: TextStyle(color: greyColor),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
    );
  }
}
