class ApplyJobResponse {
  final bool success;
  final String message;

  ApplyJobResponse({required this.success, required this.message});

  factory ApplyJobResponse.fromJson(Map<String, dynamic> json) {
    return ApplyJobResponse(
      success: json['success'] ?? false,
      message: json['message'] is List
          ? (json['message'] as List).join(", ")
          : json['message'] ?? 'Unknown error',
    );
  }
}
