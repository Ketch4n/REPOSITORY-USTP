class LikecommentModel {
  final int id;
  final int projectId;
  final int userId;
  final int rating;
  final String comment;
  final String username;
  final String email;
  final String created_at;

  LikecommentModel({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.email,
    required this.username,
    required this.created_at,
  });

  factory LikecommentModel.fromJson(Map<String, dynamic> json) {
    return LikecommentModel(
        id: json['id'],
        projectId: json['project_id'],
        userId: json['user_id'],
        rating: json['rating'],
        comment: json['comment'],
        username: json['username'],
        email: json['email'],
        created_at: json['created_at']);
  }
}
