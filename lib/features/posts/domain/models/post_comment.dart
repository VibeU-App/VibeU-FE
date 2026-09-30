class PostComment {
  final String id;
  final String authorName;
  final String? authorAvatar;
  final String content;
  final String timestamp;

  const PostComment({
    required this.id,
    required this.authorName,
    this.authorAvatar,
    required this.content,
    required this.timestamp,
  });

  PostComment copyWith({
    String? id,
    String? authorName,
    String? authorAvatar,
    String? content,
    String? timestamp,
  }) {
    return PostComment(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
