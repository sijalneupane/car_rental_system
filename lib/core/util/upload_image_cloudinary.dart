import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class UploadImageCloudinary {
  static Future<String?> uploadImageToCloudinary(File imageFile,String folderName) async {
    String? uploadedImageUrl;
    const cloudName = 'ddb1esok3';
    const uploadPreset = 'unsigned_preset';

    try {
      String fileName = path.basename(imageFile.path);

      FormData formData = FormData.fromMap({
        'file':
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
        'upload_preset': uploadPreset,
         'folder': folderName, // 👈 This tells Cloudinary where to store the image
      });

      Dio dio = Dio();

      Response response = await dio.post(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
        data: formData,
        onSendProgress: (sent, total) {
          print('Uploading: ${(sent / total * 100).toStringAsFixed(0)}%');
        },
      );

      if (response.statusCode == 200||response.statusCode == 201) {
        // setState(() {
        uploadedImageUrl = response.data['secure_url'];
        // });
        print('Uploaded Image URL: $uploadedImageUrl');
      } else {
        print('Upload failed: ${response.statusCode}');
      }
      return uploadedImageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      
    // } finally {
    //   // setState(() {
    //   // _uploading = false;
    //   // });
    }
    return null;
  }
}
