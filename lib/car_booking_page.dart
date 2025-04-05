import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_app_bar.dart';
import 'package:car_rental_system/widgets/custom_date_time_input.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:car_rental_system/widgets/padding_for_all_pages.dart';
import 'package:flutter/material.dart';

class CarBookingPage extends StatefulWidget {
  const CarBookingPage({super.key});

  @override
  State<CarBookingPage> createState() => _CarBookingPageState();
}

class _CarBookingPageState extends State<CarBookingPage> {
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: PaddingForAllPages(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomAppBar(
                    hasBackButton: true,
                    middleChild: CustomText(data: bookingStr,isPageTitle: true,),
                  ),
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
        ),
      ),
    );
  }

}