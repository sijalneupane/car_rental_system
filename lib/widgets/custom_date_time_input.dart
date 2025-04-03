import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class CustomDateTimeInput extends StatefulWidget {
  String? labelText;
  String? hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  // void Function()? onTap;
  final bool? readOnly;
  final IconData? icon;
  final String? pickerType; // "date" or "time"
  CustomDateTimeInput({
    super.key,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
   required this.controller,
    this.validator,
    // this.onTap,
    this.icon,
   required this.pickerType,this.readOnly
  });

  @override
  State<CustomDateTimeInput> createState() => _CustomDateTimeInputState();
}

class _CustomDateTimeInputState extends State<CustomDateTimeInput> {
    DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        widget.controller!.text = _selectedDate!.toString().split(' ')[0];
      });
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
        widget.controller!.text = time.format(context);
      });
    }
  }

  void _handlePicker() {
    if (widget.pickerType == "date") {
      _pickDate();
    } else if (widget.pickerType == "time") {
      _pickTime();
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomTextformfield(
        controller: widget.controller,
      readOnly:  widget.readOnly??true,
        labelText: widget.labelText,
        hintText: widget.hintText,
      // decoration: InputDecoration(
      //   suffixIcon: IconButton(
      //     onPressed: _handlePicker,
      //     icon: Icon(widget.icon),
      //   ),
      onTap: _handlePicker,
      suffixIcon: CustomNoBorderIconButton(
          onPressed: _handlePicker,
          icon: widget.icon),

      // hintText: _pickupDate == null
      //     ? 'Select Pick-Up Date'
      //     : _pickupDate.toString().split(' ')[0],
      validator: widget.validator,
    );
  }
}
