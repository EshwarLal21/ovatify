class Project {
  final int id;
  final String title;
  final String description;
  final String duration;
  final String filePath;
  final String genre;
  final String status;
  final String type;
  final String source;
  final String formattedDate;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.filePath,
    required this.genre,
    required this.status,
    required this.type,
    required this.source,
    required this.formattedDate,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      filePath: json['file_path'],
      genre: json['genre'],
      status: json['status'],
      type: json['type'],
      source: json['source'],
      formattedDate: json['formatted_date'],
    );
  }
}
