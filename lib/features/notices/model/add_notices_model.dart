class AddNoticesModel {
  String? title;
  String? noticeImageUrl;
  String? priority;
  String? category;
  List<String>? targetAudience;

  AddNoticesModel(
      {this.title,
      this.noticeImageUrl,
      this.priority,
      this.category,
      this.targetAudience});

  AddNoticesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    noticeImageUrl = json['notice_image_URL'];
    priority = json['priority'];
    category = json['category'];
    targetAudience = json['target_audience'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['notice_image_URL'] = this.noticeImageUrl;
    data['priority'] = this.priority;
    data['category'] = this.category;
    data['target_audience'] = this.targetAudience;
    return data;
  }
}
