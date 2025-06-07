import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:provider_test1/features/notices/model/add_notices_model.dart';
import 'package:provider_test1/features/notices/model/get_notices_model.dart';
import 'package:provider_test1/features/notices/services/notices_service.dart';
import 'package:provider_test1/features/notices/services/notices_service_impl.dart';
import 'package:provider_test1/utils/api_response.dart';
import 'package:provider_test1/utils/get_token_role.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/upload_image_cloudinary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticesProvider extends ChangeNotifier {
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    // dateController.dispose();
    super.dispose();
  }

  final loginFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  // final dateController = TextEditingController();

  File? imageFile; // Assuming you will handle image file separately
  String? selectedCategory;
  String? selectedPriority;
  List<String> selectedAudience = [];
  String? errorMsg;
  String userRole = '';

  final List<String> audienceOptions = ['ALL', 'BIM', 'BCA', 'CSIT'];
  checkIfAudienceAreAll(List<String?> selectedItems) {
    for (var selectedItem in selectedItems) {
      if (selectedItem == "ALL" || selectedItem == null) {
        selectedAudience = ["ALL"];
        return true;
      }
    }
    return false;
  }

  final List<String> categoryOptions = [
    'exam',
    'holiday',
    'general',
    'seminar',
  ];

  final List<String> priorityOptions = ['low', 'medium', 'high'];

  NetworkStatus _addNoticeStatus = NetworkStatus.idle;
  setAddNoticeStatus(NetworkStatus networkStatus) {
    _addNoticeStatus = networkStatus;
    notifyListeners();
  }

  NetworkStatus get getAddNoticeStatus => _addNoticeStatus;
  addNotice() async {
    setAddNoticeStatus(NetworkStatus.loading);
    if (imageFile == null) {
      errorMsg = "Please select an image";
      setAddNoticeStatus(NetworkStatus.error);
      return;
    }
    UploadImageCloudinary uploadImageCloudinary = UploadImageCloudinary();
    CloudinaryResponse? cloudinaryResponse = await uploadImageCloudinary
        .uploadImageToCloudinary(imageFile!, 'notices');
    if (cloudinaryResponse == null || cloudinaryResponse.secureUrl == null) {
      errorMsg = "Image upload failed";
      setAddNoticeStatus(NetworkStatus.error);
      return;
    }
    String? imageUrl = cloudinaryResponse.secureUrl;
    String? publicId = cloudinaryResponse.publicId;

    AddNoticesModel addNoticeModel = AddNoticesModel(
      title: titleController.text,
      noticeImageUrl: imageUrl, // Assuming you handle image upload separately
      category: selectedCategory ?? '',
      priority: selectedPriority ?? '',
      targetAudience: selectedAudience,
    );
    String token = await GetTokenRole().getToken();
    NoticesService noticesService = NoticesServiceImpl();
    // clearFormFields();
    ApiResponse response = await noticesService.addNotices(
      token,
      addNoticeModel,
    );
    if (response.networkStatus == NetworkStatus.success) {
      errorMsg = response.errorMessaage;
      setAddNoticeStatus(NetworkStatus.success);
    } else {
      try {
        setAddNoticeStatus(NetworkStatus.error);
        bool? deleted = await UploadImageCloudinary().deleteImageFromCloudinary(
          publicId ?? "",
        );
        if (deleted == false) {
          debugPrint("Failed to delete image from cloudinary");
        } else {
          debugPrint("Image deleted from cloudinary");
        }
      } on Exception catch (e) {
        debugPrint("Error deleting image: $e");
      }
      errorMsg =
          response.errorMessaage; // Note: Fix typo to errorMessage if needed
    }
  }

  NetworkStatus _getNetworkStatus = NetworkStatus.idle;
  NetworkStatus get getGetNetworkStatus => _getNetworkStatus;
  setGetNetworkStatus(NetworkStatus networkStatus) {
    _getNetworkStatus = networkStatus;
    notifyListeners();
  }

  List<GetNoticesModel> notices = []; // Add this to store notices

  // Update getNotice to store fetched notices
  getNotice() async {
    setGetNetworkStatus(NetworkStatus.loading);
    NoticesService noticeServiceImpl = NoticesServiceImpl();
    String token = await GetTokenRole().getToken();
    ApiResponse response = await noticeServiceImpl.getNotices(token);
    if (response.networkStatus == NetworkStatus.success) {
      notices =
          (response.data as List)
              .map((json) => GetNoticesModel.fromJson(json))
              .toList();
      setGetNetworkStatus(NetworkStatus.success);
    } else {
      errorMsg =
          response.errorMessaage; // Note: Fix typo to errorMessage if needed
      setGetNetworkStatus(NetworkStatus.error);
    }
  }

  NetworkStatus _deleteNoticeStatus = NetworkStatus.idle;
  NetworkStatus get getDeleteNoticeStatus => _deleteNoticeStatus;
  setDeleteNoticeStatus(NetworkStatus networkStatus) {
    _deleteNoticeStatus = networkStatus;
    notifyListeners();
  }

  Future<void> deleteNotice(String noticeId, {String? publicId}) async {
    setDeleteNoticeStatus(NetworkStatus.loading);
    NoticesService noticesService = NoticesServiceImpl();
    String token = await GetTokenRole().getToken();
    ApiResponse response = await noticesService.deleteNotices(token, noticeId);
    if (response.networkStatus == NetworkStatus.success) {
      // Optionally delete image from Cloudinary if publicId is provided
      if (publicId != null && publicId.isNotEmpty) {
        try {
          bool? deleted = await UploadImageCloudinary().deleteImageFromCloudinary(publicId);
          if (deleted == false) {
            debugPrint("Failed to delete image from cloudinary");
          } else {
            debugPrint("Image deleted from cloudinary");
          }
        } on Exception catch (e) {
          debugPrint("Error deleting image: $e");
        }
      }
      // Remove the notice from the local list
      notices.removeWhere((notice) => notice.id == noticeId);
      setDeleteNoticeStatus(NetworkStatus.success);
      notifyListeners();
    } else {
      errorMsg = response.errorMessaage;
      setDeleteNoticeStatus(NetworkStatus.error);
    }
  }
  void afterPickingImage(File? imageFile) {
    if (imageFile != null) {
      // Handle the picked image file
      this.imageFile = imageFile;
      debugPrint("Image picked: ${imageFile.path}");
    } else {
      // Handle case where no image is picked
      this.imageFile = null;
      debugPrint("No image picked");
    }
  }

  Future<void> loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString('role') ?? '';
    notifyListeners();
  }

  void clearFormFields() {
    loginFormKey.currentState?.reset();
    titleController.clear();
    contentController.clear();
    // dateController.clear();
    selectedCategory = null;
    selectedPriority = null;
    selectedAudience.clear();
    print(titleController.text);
    print(selectedCategory);
    notifyListeners();
  }
}
