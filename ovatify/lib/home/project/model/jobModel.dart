class JobResponse {
  final bool success;
  final String message;
  final List<Job> jobs;

  JobResponse({
    required this.success,
    required this.message,
    required this.jobs,
  });

  factory JobResponse.fromJson(Map<String, dynamic> json) {
    return JobResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      jobs: json['jobs'] != null
          ? List<Job>.from(json['jobs'].map((job) => Job.fromJson(job)))
          : [],
    );
  }
}

class Job {
  final int id;
  final String title;
  final String description;
  final String status;
  final String createdAt;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}