class GetNoticesModel {
  int? id;
  String? title;
  String? content;
  String? noticeDate;
  int? issuedBy;
  String? issuedByUsername;
  String? priority;
  String? category;
  List<String>? targetAudience;
  String? createdAt;
  String? updatedAt;

  GetNoticesModel(
      {this.id,
      this.title,
      this.content,
      this.noticeDate,
      this.issuedBy,
      this.issuedByUsername,
      this.priority,
      this.category,
      this.targetAudience,
      this.createdAt,
      this.updatedAt});

  GetNoticesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    noticeDate = json['notice_date'];
    issuedBy = json['issued_by'];
    issuedByUsername = json['issued_by_username'];
    priority = json['priority'];
    category = json['category'];
    targetAudience = json['target_audience'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['notice_date'] = this.noticeDate;
    data['issued_by'] = this.issuedBy;
    data['issued_by_username'] = this.issuedByUsername;
    data['priority'] = this.priority;
    data['category'] = this.category;
    data['target_audience'] = this.targetAudience;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
