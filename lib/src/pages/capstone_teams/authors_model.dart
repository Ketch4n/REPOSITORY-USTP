// ignore_for_file: non_constant_identifier_names

class AuthorsModel {
  final int id;
  final String group_name;
  final int project_id;
  final String title;
  final int project_type;
  final String year_published;
  // final String member_3;

  final List<String?> authors;

  AuthorsModel({
    required this.id,
    required this.group_name,
    required this.project_id,
    required this.title,
    required this.project_type,
    required this.year_published,
    // required this.member_3,

    required this.authors,
  });

  // Factory method to create a AuthorsModel instance from a JSON map
  factory AuthorsModel.fromJson(Map<String, dynamic> json) {
    return AuthorsModel(
      id: json['id'],
      group_name: json['group_name'],
      project_id: json['project_id'],
      title: json['title'],
      project_type: json['project_type'],
      year_published: json['year_published'],
      // member_3: json['member_3'],

      authors: List<String?>.from(
          json['authors']), // Convert JSON array to List<String>
    );
  }

  // Method to convert a AuthorsModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_name': group_name,
      'project_id': project_id,
      'title': title,
      'project_type': project_type,
      'year_published': year_published,
      // 'member_3': member_3,

      'authors': authors,
    };
  }
}
