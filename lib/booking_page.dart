import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/widgets/custom_date_time_input.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  final _pickupLocationController = TextEditingController();

  final _dropoffLocationController = TextEditingController();
  final _pickupDateController = TextEditingController();
  final _pickUpTimeController = TextEditingController();

  DateTime? _pickupDate;

  TimeOfDay? _pickupTime;

  bool _insuranceAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextformfield(
                      controller: _pickupLocationController,
                      labelText: 'Pick-Up Location',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter pick-up location';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextformfield(
                      controller: _dropoffLocationController,
                      labelText: 'Drop-Off Location',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter drop-off location';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDateTimeInput(
                      labelText: "Pick-Up Date",
                      hintText: "Select Pick Up date",
                      pickerType: "date",
                      controller: _pickupDateController,
                    ),
                  ),CustomSizedBox(width: 0.02,),
                  Expanded(child: CustomDateTimeInput(
                    labelText: "Pick-Up time",
                    pickerType: "time", controller: _pickUpTimeController,
                  ))
                ],
              ),
              CheckboxListTile(
                title: const Text('Agree to Insurance Terms'),
                value: _insuranceAgreed,
                onChanged: (value) {
                  setState(() {
                    _insuranceAgreed = value!;
                  });
                },
              ),
              CustomElevatedbutton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _pickupDate != null &&
                      _pickupTime != null &&
                      _insuranceAgreed) {
                    DisplaySnackbar.show(
                        context, "Form Submitted Successfully!");
                  } else {
                    DisplaySnackbar.show(
                        context, "Please fill all fields correctly.");
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
