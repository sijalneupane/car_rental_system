import 'dart:io';
import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_elevatedbutton.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final String? labelText;
  final String? initialImageUrl;
  final void Function(File? imageFile) afterPickingImage;
  final String? Function(File? imageFile)? validator;

  CustomImagePicker({
    super.key,
    this.initialImageUrl,
    required this.afterPickingImage,
    this.labelText,
    this.validator,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  late FormFieldState<File> _formFieldState; // To store the FormFieldState
  String? tempInitiaLImageUrl;
  @override
  void initState() {
    super.initState();
    setState(() {
      tempInitiaLImageUrl = widget.initialImageUrl;
    });
    // If there's an initialImageUrl, you might want to handle it here (optional)
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked != null) {
      File? file = File(picked.path);
      setState(() {
        _imageFile = file;
        tempInitiaLImageUrl = null;
        _formFieldState.didChange(file); // Update the FormField value
      });
      widget.afterPickingImage(file); // Call the callback
    }
  }

  Future<void> _unpickImage() async {
    setState(() {
      _imageFile = null;
      tempInitiaLImageUrl = widget.initialImageUrl;
      _formFieldState.didChange(null); // Clear the FormField value
    });
    widget.afterPickingImage(_imageFile); // Call the callback
  }

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: _imageFile,
      validator: tempInitiaLImageUrl == null
          ? widget.validator
          : (File? filename) {
              return null;
            },
      builder: (FormFieldState<File> field) {
        // Store the FormFieldState for later use
        _formFieldState = field;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: widget.labelText ?? "",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: _sourceOptionsUI,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildImagePreview(),
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(color: errorColor, fontSize: 12),
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buttons(
                    _sourceOptionsUI,
                    Icons.upload,
                    "Choose Image",
                    backgroundColor: secondaryColor,
                  ),
                ),
                CustomSizedBox(width: 0.02),
                if (_imageFile != null)
                  Expanded(
                    child: _buttons(
                      _unpickImage,
                      Icons.cancel_outlined,
                      cancelStr,
                      backgroundColor: errorColor,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buttons(
    dynamic Function()? onPressed,
    IconData? icon,
    String buttonLabel, {
    Color? backgroundColor,
  }) {
    return CustomElevatedbutton(
      borderColor: Colors.transparent,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          CustomSizedBox(width: 0.02),
          Text(buttonLabel),
        ],
      ),
    );
  }

  void _sourceOptionsUI() {
    showModalBottomSheet(
      barrierColor: Colors.black.withAlpha(5),
      elevation: 8,
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text(cameraStr),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(galleryStr),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_imageFile != null) {
      return Image.file(_imageFile!,
          width: 200, height: 200, fit: BoxFit.cover);
    } else if (widget.initialImageUrl != null) {
      return Image.network(widget.initialImageUrl!,
          width: 200, height: 200, fit: BoxFit.cover);
    } else {
      return const Icon(Icons.image, size: 100, color: Colors.grey);
    }
  }
}
