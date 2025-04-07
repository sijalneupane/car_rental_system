import 'package:car_rental_system/core/util/dialog_box.dart';
import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_app_bar.dart';
import 'package:car_rental_system/widgets/custom_checkbox.dart';
import 'package:car_rental_system/widgets/custom_date_time_input.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_image_network.dart';
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    hasBackButton: true,
                    middleChild: CustomText(
                      data: bookingStr,
                      isPageTitle: true,
                    ),
                  ),
                  CustomImageNetwork(
                    name: 'https://www.pngmart.com/files/22/Audi-Q7-PNG.png',
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: CustomText(data: "360°", color: Colors.white),
                    ),
                  ),
                  CustomSizedBox(height: 0.01), // Spacer, // Spacer

                  CustomTextformfield(
                    controller: _pickupLocationController,
                    labelText: pickUpLocationStr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return pickUpLocationValidationStr;
                      }
                      return null;
                    },
                  ),
                  CustomTextformfield(
                    controller: _dropoffLocationController,
                    labelText: dropOffLocationStr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return dropOffLocationValidationStr;
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDateTimeInput(
                          suffixIcon: CustomIcons(icon: Icons.date_range),
                          labelText: pickUpDateStr,
                          hintText: selectDateStr,
                          pickerType: dateStr,
                          controller: _pickupDateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return pickUpDateValidationStr;
                            }
                            return null;
                          },
                        ),
                      ),
                      CustomSizedBox(
                        width: 0.02,
                      ),
                      Expanded(
                          child: CustomDateTimeInput(
                        suffixIcon: CustomIcons(
                            icon: Icons.history_toggle_off_outlined),
                        labelText: pickUpTimeStr,
                        hintText: selectTimeStr,
                        pickerType: timeStr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return pickUpTimeValidationStr;
                          }
                          return null;
                        },
                        controller: _pickUpTimeController,
                      ))
                    ],
                  ),
                  CustomSizedBox(
                    height: 0.01,
                  ),
                  CustomText(
                    data: insuranceStr,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomSizedBox(
                    height: 0.01,
                  ),
                  CustomCheckbox(
                      value: _insuranceAgreed,
                      onChanged: (value) {
                        setState(() {
                          _insuranceAgreed = value!;
                        });
                      },
                      data: insuranceCoveragesAgreementStr),
                  CustomSizedBox(
                    height: 0.01,
                  ),
                  Column(
                    children: [
                      CustomElevatedbutton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _insuranceAgreed) {
                            // DialogBox.showCustomConfirmationDialog(
                            //   icon: Icons.people,
                            //   context: context,
                            //   title: "Booking Confirmation",
                            //   message: "Booking  button clicked ! ! !",
                            //   onOkPressed: () {
                            //     DisplaySnackbar.show(
                            //       context,
                            //       "Clicked ok in ok button ${_dropoffLocationController.text}",
                            //     );
                            //   },
                            //   onCancelPressed: () {
                            //     DisplaySnackbar.show(
                            //         context, "Clicked ok in cancel box");
                            //   },
                            // ); 
                            // DisplaySnackbar.show(
                            //     context, "Form Submitted Successfully!");
                          } else {
                            DisplaySnackbar.show(
                                context, "Please fill all fields correctly.");
                          }
                        },
                        child: const Text('Continue'),
                      ),
                    ],
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
