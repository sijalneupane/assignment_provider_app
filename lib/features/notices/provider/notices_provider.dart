import 'package:flutter/material.dart';
import 'package:provider_test1/features/notices/model/add_notices_model.dart';
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

  // final loginFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final dateController = TextEditingController();

  String? selectedCategory;
  String? selectedPriority;
  List<String> selectedAudience = [];
  String? errorMsg;

  final List<String> audienceOptions = ['ALL', 'BIM', 'BCA', 'CSIT'];
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
    clearFormFields();
  }

  void clearFormFields() {
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
