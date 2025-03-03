class Task {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdAt;
  final String updatedAt;

  Task(
      {required this.id,
        required this.title,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
