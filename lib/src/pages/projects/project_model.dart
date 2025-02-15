// ignore_for_file: non_constant_identifier_names

class ProjectModel {
  final int id;
  final String title;
  final String year_published;
  final int semester;
  final int project_type;
  final String group_name;
  final String? manuscript;
  final String? poster;
  final String? video;
  final String? zip;

  // final int privacy;
  final List<String?> authors;

  ProjectModel({
    required this.id,
    required this.title,
    required this.year_published,
    required this.semester,
    required this.project_type,
    required this.group_name,
    this.manuscript,
    this.poster,
    this.video,
    this.zip,

    // required this.privacy,
    required this.authors,
  });

  // Factory method to create a ProjectModel instance from a JSON map
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      year_published: json['year_published'],
      semester: json['semester'],
      project_type: json['project_type'],
      group_name: json['group_name'],
      manuscript: json['manuscript'],
      poster: json['poster'],
      video: json['video'],
      zip: json['zip'],

      // privacy: json['privacy'],
      authors: List<String?>.from(json['authors'] ?? []),
    );
  }

  // Method to convert a ProjectModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year_published': year_published,
      'semester': semester,
      'project_type': project_type,
      'group_name': group_name,
      'manuscript': manuscript,
      'poster': poster,
      'video': video,
      'zip': zip,

      // 'privacy': privacy,
      'authors': authors,
    };
  }
}
