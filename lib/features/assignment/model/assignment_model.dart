class AssignmentModel {
  int? id;
  String? subjectName;
  String? semester;
  String? deadline;
  String? faculty;
  String? title;
  String? description;

  AssignmentModel(
      {this.id,this.subjectName,
      this.semester,
        this.deadline,
      this.faculty,
      this.title,
      this.description});

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subjectName'];
    semester = json['semester'];
     deadline = json['deadline'];
    faculty = json['faculty'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjectName'] = this.subjectName;
    data['semester'] = this.semester;
    data['deadline'] = this.deadline;
    data['faculty'] = this.faculty;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
