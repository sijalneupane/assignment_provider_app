class AddAssignmentModel {
  String? subjectName;
  String? semester;
  String? faculty;
  String? title;
  String? description;
  int? teacherId;

  AddAssignmentModel(
      {this.subjectName,
      this.semester,
      this.faculty,
      this.title,
      this.teacherId,
      this.description});

  AddAssignmentModel.fromJson(Map<String, dynamic> json) {
    subjectName = json['subjectName'];
    semester = json['semester'];
    faculty = json['faculty'];
    title = json['title'];
    teacherId = json['teacherId'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectName'] = this.subjectName;
    data['semester'] = this.semester;
    data['faculty'] = this.faculty;
    data['title'] = this.title;
    data['teacherId'] = this.teacherId;
    data['description'] = this.description;
    return data;
  }
}
