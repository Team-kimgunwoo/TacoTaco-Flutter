class StatusModel<T> {
  final int status;
  final String message;
  final T? data;

  StatusModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory StatusModel.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return StatusModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T?) toJsonT) => {
    'status': status,
    'message': message,
    'data': data != null ? toJsonT(data) : null,
  };
}
