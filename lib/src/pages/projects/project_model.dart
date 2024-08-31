// ignore_for_file: non_constant_identifier_names

class ProjectModel {
  final int id;
  final String title;
  final String year_published;
  final String category;
  final String group_name;
  final List<String> author;

  ProjectModel({
    required this.id,
    required this.title,
    required this.year_published,
    required this.category,
    required this.group_name,
    required this.author,
  });

  // Factory method to create a ProjectModel instance from a JSON map
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      year_published: json['year_published'],
      category: json['category'],
      group_name: json['group_name'],
      author: List<String>.from(
          json['author']), // Convert JSON array to List<String>
    );
  }

  // Method to convert a ProjectModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year_published': year_published,
      'category': category,
      'group_name': group_name,
      'author': author,
    };
  }
}
