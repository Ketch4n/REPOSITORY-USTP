// ignore_for_file: non_constant_identifier_names

class ProjectModel {
  final int id;
  final String title;
  final String year_published;
  final int project_type;
  final String group_name;
  // final int privacy;
  // final List<String> author;

  ProjectModel({
    required this.id,
    required this.title,
    required this.year_published,
    required this.project_type,
    required this.group_name,
    // required this.privacy,
    // required this.author,
  });

  // Factory method to create a ProjectModel instance from a JSON map
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      year_published: json['year_published'],
      project_type: json['project_type'],
      group_name: json['group_name'],
      // privacy: json['privacy'],
      // author: List<String>.from(
      //     json['author']), // Convert JSON array to List<String>
    );
  }

  // Method to convert a ProjectModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year_published': year_published,
      'project_type': project_type,
      'group_name': group_name,
      // 'privacy': privacy,
      // 'author': author,
    };
  }
}
