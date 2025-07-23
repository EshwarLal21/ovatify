class JobDetailModel {
  final bool success;
  final String message;
  final String? error;

  JobDetailModel({required this.success, required this.message, this.error});

  factory JobDetailModel.fromJson(Map<String, dynamic> json) {
    return JobDetailModel(
      success: json['success'],
      message: json['message'],
      error: json['error'],
    );
  }
}
