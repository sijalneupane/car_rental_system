import 'dart:io';

import 'package:car_rental_system/core/util/dialog_box.dart';
import 'package:car_rental_system/core/util/display_snackbar.dart';
import 'package:car_rental_system/core/util/get_user_info.dart';
import 'package:car_rental_system/core/util/hide_keyboard.dart';
import 'package:car_rental_system/core/util/route_generator.dart';
import 'package:car_rental_system/core/util/spin_kit.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/core/util/upload_image_cloudinary.dart';
import 'package:car_rental_system/model/car.dart';
import 'package:car_rental_system/model/user.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_dropdown.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_icons.dart';
import 'package:car_rental_system/widgets/custom_image_picker.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:car_rental_system/widgets/custom_textformfield.dart';
import 'package:car_rental_system/widgets/padding_for_all_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ... (imports remain the same)

class AddCarForm extends StatefulWidget {
  Car? car;
   AddCarForm({super.key,this.car});

  @override
  State<AddCarForm> createState() => _AddCarFormState();
}

class _AddCarFormState extends State<AddCarForm> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
 if(widget.car!=null){
     _carNameController.text=widget.car?.carName??""; 
_carBrandController.text=widget.car?.carBrand??"";
_carTypeController.text=widget.car?.carType??"";
_passengerCapacityController.text=widget.car?.passengerCapacity??"";
_priceController.text=widget.car?.rentPrice??"";
_fuelCapacityController.text=widget.car?.fuelCapacity??"";
 }
  }

  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _carBrandController = TextEditingController();
  final TextEditingController _carTypeController = TextEditingController();
  final TextEditingController _passengerCapacityController =
      TextEditingController();
  final TextEditingController _fuelCapacityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<String> carType = [automaticTypeStr, manualTypeStr];
  bool loader = false;
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ui(),
            loader ? Loader.backdropFilter(context) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget ui() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: PaddingForAllPages(
          child: Column(
            children: [
              Row(
                children: [
                  CustomBackPageIcon(),
                  Expanded(
                    child: CustomText(
                      data: addCarDetailsStr,
                      isPageTitle: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              CustomTextformfield(
                labelText: carNameLabelStr,
                hintText: carNameHintStr,
                controller: _carNameController,
                prefixIcon: CustomIcons(icon: Icons.car_repair),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return carNameValidateString;
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextformfield(
                      labelText: carBrandLabelStr,
                      hintText: carBrandHintStr,
                      controller: _carBrandController,
                      prefixIcon: CustomIcons(icon: Icons.business),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return carBrandValidateString;
                        }
                        return null;
                      },
                    ),
                  ),
                  CustomSizedBox(width: 0.02),
                  Expanded(
                    child: CustomDropdown(
                      value:_carTypeController.text ,
                      dropDownItemList: carType,
                      labelText: carTypeLabelStr,
                      hintText: carTypeHintStr,
                      controller: _carTypeController,
                      prefixIcon: CustomIcons(icon: Icons.directions_car),
                      onChanged: (value) {
                        setState(() {
                          _carTypeController.text = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return carTypeValidateString;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              CustomTextformfield(
                keyboardType: TextInputType.number,
                labelText: totalPassengerCapacityLabelStr,
                hintText: totalPassengerCapacityHintStr,
                controller: _passengerCapacityController,
                prefixIcon: CustomIcons(icon: Icons.group),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return totalPassengerCapacityValidateString;
                  }
                  return null;
                },
              ),
              CustomTextformfield(
                keyboardType: TextInputType.number,
                labelText: fuelCapacityLabelStr,
                hintText: fuelCapacityHintStr,
                controller: _fuelCapacityController,
                prefixIcon: CustomIcons(icon: Icons.local_gas_station),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return fuelCapacityValidateString;
                  }
                  return null;
                },
              ),
              CustomTextformfield(
                keyboardType: TextInputType.number,
                labelText: priceLabelStr,
                hintText: priceHintStr,
                controller: _priceController,
                prefixIcon: CustomIcons(icon: Icons.currency_rupee_sharp),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return priceValidateString;
                  }
                  return null;
                },
              ),
              CustomSizedBox(height: 0.02),
              CustomImagePicker(
                initialImageUrl:widget.car?.imageUrl ,
                validator: (imageFile) {
                  if (imageFile == null) {
                    return imageValidationStr;
                  }
                  double imageLength = imageFile.lengthSync() / (1024 * 1024);
                  String fileExtension =
                      imageFile.path.split('.').last.toLowerCase();

                  if (!allowedExtensions.contains(fileExtension)) {
                    return imageExtensionsValidationStr;
                  }
                  if (imageLength > 4) {
                    return imageSizeValidationStr;
                  }
                  return null; // Validation passed
                },
                labelText: carImageLabelStr,
                afterPickingImage: (File imageFile) async {
                  setState(() {
                    _selectedImage = imageFile; // Store the selected image
                  });
                  DialogBox.showAlertBox(
                    context: context,
                    title: "Image Selected",
                    message: _selectedImage!.path,
                    onOkPressed: () {},
                  );
                },
              ),
              CustomSizedBox(height: 0.02),
              CustomElevatedbutton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loader = true;
                    });
                    HideKeyboard.hideKeyboard(context);
                    Future.delayed(const Duration(seconds: 2), () async {
                      try {
                        String? imageUrl;
                        if (_selectedImage != null) {
                          // Upload the image to Cloudinary (or your preferred service)
                          imageUrl = await UploadImageCloudinary
                              .uploadImageToCloudinary(
                                  _selectedImage!, "carimage");
                          if (imageUrl == null) {
                            throw Exception("Image upload failed");
                          }
                        }
                        //getting the userId from sharedprefences
                        GetUserInfo getUserInfo = GetUserInfo();
                        String? userId = await getUserInfo.getUserId();
                        Car obj = Car(
                            carName: _carNameController.text,
                            carBrand: _carBrandController.text,
                            carType: _carTypeController.text,
                            passengerCapacity:
                                _passengerCapacityController.text,
                            fuelCapacity: _fuelCapacityController.text,
                            rentPrice: _priceController.text,
                            imageUrl: imageUrl,
                            userId: userId);
                        FirebaseFirestore firebaseFirestore =
                            FirebaseFirestore.instance;
                        await firebaseFirestore
                            .collection("cars")
                            .add(obj.toJson());
                        setState(() {
                          loader = false;
                        });
                        DisplaySnackbar.show(
                          context,
                          carDetailsAddedSuccessStr,
                          isSuccess: true,
                        );
                        // _carNameController.clear();
                        // _carBrandController.clear();
                        // _carTypeController.clear();
                        // _passengerCapacityController.clear();
                        // _fuelCapacityController.clear();
                        // _priceController.clear();
                        Navigator.pop(context);
                      } catch (e) {
                        setState(() {
                          loader = false;
                        });
                        DisplaySnackbar.show(context, e.toString(),
                            isError: true);
                      }
                    });
                  }
                },
                child: const Text(submitStr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
