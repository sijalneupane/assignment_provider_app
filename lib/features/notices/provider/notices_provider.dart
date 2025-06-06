import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider_test1/features/notices/model/add_notices_model.dart';
import 'package:provider_test1/features/notices/model/get_notices_model.dart';
import 'package:provider_test1/features/notices/services/notices_service.dart';
import 'package:provider_test1/features/notices/services/notices_service_impl.dart';
import 'package:provider_test1/utils/api_response.dart';
import 'package:provider_test1/utils/get_token_role.dart';
import 'package:provider_test1/utils/network_status.dart';

class NoticesProvider extends ChangeNotifier {
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    dateController.dispose();
    super.dispose();
  }

  final loginFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final dateController = TextEditingController();

  String? selectedCategory;
  String? selectedPriority;
  List<String> selectedAudience = [];
  String? errorMsg;

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
    AddNoticesModel addNoticeModel = AddNoticesModel(
      title: titleController.text,
      content: contentController.text,
      noticeDate: dateController.text,
      category: selectedCategory ?? '',
      priority: selectedPriority ?? '',
      targetAudience: selectedAudience,
    );
    String token = await GetTokenRole().getToken();
    NoticesService noticesService = NoticesServiceImpl();
    clearFormFields();
    ApiResponse response = await noticesService.addNotices(
      token,
      addNoticeModel,
    );
    if (response.networkStatus == NetworkStatus.success) {
      errorMsg = response.errorMessaage;
      setAddNoticeStatus(NetworkStatus.success);
    } else {
      setAddNoticeStatus(NetworkStatus.error);
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

void afterPickingImage(File? imageFile) {
  if (imageFile != null) {
    // Handle the picked image file
    debugPrint("Image picked: ${imageFile.path}");
  } else {
    // Handle case where no image is picked
    debugPrint("No image picked");
  }
}

  void clearFormFields() {
    loginFormKey.currentState?.reset();
    titleController.clear();
    contentController.clear();
    dateController.clear();
    selectedCategory = null;
    selectedPriority = null;
    selectedAudience.clear();
    print(titleController.text);
    print(selectedCategory);
    notifyListeners();
  }
}
