import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class CloudinaryUploadWithDio extends StatefulWidget {
  @override
  _CloudinaryUploadWithDioState createState() => _CloudinaryUploadWithDioState();
}

class _CloudinaryUploadWithDioState extends State<CloudinaryUploadWithDio> {
  File? _image;
  String? _uploadedImageUrl;
  bool _uploading = false;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      await uploadImageToCloudinary(_image!);
    }
  }

  Future<void> uploadImageToCloudinary(File imageFile) async {
    const cloudName = 'ddb1esok3';
    const uploadPreset = 'unsigned_preset';

    setState(() {
      _uploading = true;
    });

    try {
      String fileName = path.basename(imageFile.path);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path, filename: fileName),
        'upload_preset': uploadPreset,
      });

      Dio dio = Dio();

      Response response = await dio.post(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
        data: formData,
        onSendProgress: (sent, total) {
          print('Uploading: ${(sent / total * 100).toStringAsFixed(0)}%');
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _uploadedImageUrl = response.data['secure_url'];
        });
        print('Uploaded Image URL: $_uploadedImageUrl');
      } else {
        print('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cloudinary Upload with Dio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            _image != null ? Image.file(_image!, height: 200) : Text('No image selected'),
            SizedBox(height: 20),
            _uploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Pick & Upload Image'),
                  ),
            SizedBox(height: 20),
            if (_uploadedImageUrl != null) ...[
              Text('Image URL:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              SelectableText(_uploadedImageUrl!),
            ]
          ],
        ),
      ),
    );
  }
}
