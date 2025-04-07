import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

class CustomSearchbar extends StatefulWidget {
  String? hintText;
  void Function(String)? onChanged;
  void Function()? onTap;
  bool? readOnly;
  bool? autofocus;
  CustomSearchbar(
      {super.key,
      this.hintText,
      this.onChanged,
      this.onTap,
      this.readOnly,
      this.autofocus});

  @override
  State<CustomSearchbar> createState() => _CustomSearchbarState();
}

class _CustomSearchbarState extends State<CustomSearchbar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      readOnly: widget.readOnly ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        hintText: widget.hintText,
        prefixIcon: CustomIcons(icon: Icons.search),
        contentPadding: const EdgeInsets.all(8),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: primaryColor)),
        hintStyle: const TextStyle(color: greyColor),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
