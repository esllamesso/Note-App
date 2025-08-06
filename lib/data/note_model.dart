class NoteModel {
  final String headLine;
  final String description;
  final DateTime createdAt;
  final String ? imageUrl;

  NoteModel({
    required this.headLine,
    required this.description,
    required this.createdAt,
    this.imageUrl
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      headLine: json['headLine'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] ?? "" as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headLine': headLine,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}