class AddNoticesModel {
  String? title;
  String? content;
  String? noticeDate;
  String? priority;
  String? category;
  List<String>? targetAudience;

  AddNoticesModel(
      {this.title,
      this.content,
      this.noticeDate,
      this.priority,
      this.category,
      this.targetAudience});

  AddNoticesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    noticeDate = json['notice_date'];
    priority = json['priority'];
    category = json['category'];
    targetAudience = json['target_audience'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['notice_date'] = this.noticeDate;
    data['priority'] = this.priority;
    data['category'] = this.category;
    data['target_audience'] = this.targetAudience;
    return data;
  }
}
