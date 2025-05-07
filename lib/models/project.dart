class Project {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isOngoing;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isOngoing,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      status: json['status'] ?? 'unknown',
      createdBy: json['created_by'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isOngoing: json['status'] == 'ongoing',
    );
  }
}