import 'dart:io';
import 'package:cloudinary/cloudinary.dart';

class UploadImageCloudinary {
  Future<CloudinaryResponse?> uploadImageToCloudinary(
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
      } else {
        print('Upload failed: ${response.error}');

      }
      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }

  }

  Future<bool> deleteImageFromCloudinary(String publicId) async {
    final cloudinary = Cloudinary.signedConfig(cloudName: 'ddb1esok3',apiKey: '945181531472972', apiSecret: 'pLPjV-bNTMtyvfWPM64BUrvt9Ug');
    const uploadPreset = 'unsigned_preset';
    try {
      final response = await cloudinary.destroy( 
         publicId,
         
        resourceType: CloudinaryResourceType.image,
        invalidate: true
      );

      if (response.isSuccessful) {
        print('Image deleted successfully');
        return true;
      } else {
        print('Delete failed: ${response.error}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
}
}
