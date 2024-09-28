class Download {
  final String email;
  final int projectId;
  final int downloads;

  Download({
    required this.email,
    required this.projectId,
    required this.downloads,
  });

  factory Download.fromJson(Map<String, dynamic> json) {
    return Download(
      email: json['email'],
      projectId: json['project_id'],
      downloads: json['downloads'],
    );
  }
}
