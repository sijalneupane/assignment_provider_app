import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider_test1/utils/display_snackbar.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/utils/upload_image_cloudinary.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_image_picker.dart';
import 'package:provider_test1/widgets/custom_text.dart';

class AddNotice2 extends StatelessWidget {
  AddNotice2({super.key});
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomText(
                data: addNoticeStr,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              CustomImagePicker(
                validator: (imageFile) {
                  if (imageFile == null) {
                    return "Please select an image";
                  }
                  return null;
                },
                afterPickingImage: (imageFile) {
                  if (imageFile != null) {
                    this.imageFile = imageFile;
                    DisplaySnackbar.show(context, imageFile.path);
                  }
                },
              ),
              CustomElevatedbutton(
                onPressed: () async{
                  // Action to add notice
                  try {
                  // String? imageUrl= await UploadImageCloudinary().uploadImageToCloudinary(
                  //     imageFile!,
                  //     'notices',
                  //   );
                    // DisplaySnackbar.show(
                    //   context,
                    //   // 'Image uploaded successfully at <<<<=---- $imageUrl',
                    // );
                  } on Exception catch (e) {
                    DisplaySnackbar.show(context, 'Error uploading image: $e');
                  }
                },
                child: const Text("Add Notice"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
