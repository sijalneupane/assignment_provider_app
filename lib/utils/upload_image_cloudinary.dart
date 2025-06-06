import 'dart:io';
import 'package:cloudinary/cloudinary.dart';

class UploadImageCloudinary {
  Future<String?> uploadImageToCloudinary(
    File imageFile,
    String folderName,
  ) async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: 'ddb1esok3',);
    const uploadPreset = 'unsigned_preset';
    try {
      final response = await cloudinary.unsignedUpload(
        file: imageFile.path,
        resourceType: CloudinaryResourceType.image,
        folder: folderName,
        fileName: imageFile.uri.pathSegments.last,
        uploadPreset: uploadPreset,

        progressCallback: (sent, total) {
          print('Uploading: ${(sent / total * 100).toStringAsFixed(0)}%');
        },
      );

      if (response.isSuccessful && response.secureUrl != null) {
        print('Uploaded Image URL: ${response.secureUrl}');
        return response.secureUrl;
      } else {
        print('Upload failed: ${response.error}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return null;
  }
}
