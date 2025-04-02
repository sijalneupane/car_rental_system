import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class CustomDateInput extends StatefulWidget {
  String? labelText;
  String? hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function()? onTap;
  CustomDateInput({
    super.key,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.onTap,
  });

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  @override
  Widget build(BuildContext context) {
    return CustomTextformfield(
      labelText: "Pick-Up Date",
      hintText: "Select Pick Up date",
      readOnly: true,
      onTap: widget.onTap,
      suffixIcon: CustomNoBorderIconButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              setState(() {
                // _pickupDate = date;
                widget.controller!.text = date.toString().split(' ')[0];
                print(widget.controller!.text);
              });
            }
          },
          icon: Icons.date_range),
      controller: widget.controller,

      // hintText: _pickupDate == null
      //     ? 'Select Pick-Up Date'
      //     : _pickupDate.toString().split(' ')[0],
      validator: widget.validator,
    );
  }
}
