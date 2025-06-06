import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_test1/utils/color_utils.dart';

import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_icons.dart';
import 'package:provider_test1/widgets/custom_sized_box.dart';
import 'package:provider_test1/widgets/custom_text.dart';

class CustomImagePicker extends StatefulWidget {
  final String? labelText;
  final File? initialImageFile;
  final void Function(File? imageFile) afterPickingImage;
  final String? Function(File? imageFile)? validator;

  const CustomImagePicker({
    super.key,
    this.initialImageFile,
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
  late FormFieldState<File> _formFieldState;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.initialImageFile;
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked != null) {
      final file = File(picked.path);
      setState(() {
        _imageFile = file;
        _formFieldState.didChange(file);
      });
      widget.afterPickingImage(file);
    }
  }

  Future<void> _unpickImage() async {
    setState(() {
      _imageFile = null;
      _formFieldState.didChange(null);
    });
    widget.afterPickingImage(null);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: _imageFile,
      validator: widget.validator,
      builder: (FormFieldState<File> field) {
        _formFieldState = field;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: widget.labelText ?? addImageStr,
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
          ],
        );
      },
    );
  }

  void _sourceOptionsUI() {
    const TextStyle _optionsTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withAlpha(5),
      elevation: 8,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                if (_imageFile != null) ...[
                  ListTile(
                    leading: CustomIcons(icon: Icons.remove_red_eye_rounded),
                    title: const Text(viewImgStr, style: _optionsTextStyle),
                    onTap: () {
                      Navigator.pop(context);
                      if (_imageFile != null) {
                        showDialog(
                          context: context,
                          builder:
                              (_) => Dialog(
                                insetPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 5,
                                ),
                                backgroundColor: Colors.green,
                                shadowColor: Colors.black,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: InteractiveViewer(
                                    minScale: 0.5,
                                    maxScale: 2,
                                    scaleEnabled: true,
                                    clipBehavior: Clip.antiAlias,
                                    trackpadScrollCausesScale: true,
                                    panEnabled: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(_imageFile!),
                                    ),
                                  ),
                                ),
                              ),
                        );
                      }
                    },
                  ),

                  ListTile(
                    leading: CustomIcons(icon: Icons.delete),
                    title: const Text(deleteImgStr, style: _optionsTextStyle),
                    onTap: () {
                      Navigator.pop(context);
                      _unpickImage();
                    },
                  ),
                  Divider(),
                ],
                ListTile(
                  leading: CustomIcons(icon: Icons.photo_camera),
                  title: const Text(cameraStr, style: _optionsTextStyle),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: CustomIcons(icon: Icons.photo_library),
                  title: const Text(galleryStr, style: _optionsTextStyle),
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
      return Image.file(
        _imageFile!,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return const Icon(Icons.image, size: 100, color: Colors.grey);
    }
  }
}
