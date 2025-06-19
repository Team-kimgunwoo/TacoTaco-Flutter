class MypageResponse {
  final int status;
  final String message;
  final MypageModel data;

  MypageResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MypageResponse.fromJson(Map<String, dynamic> json) {
    return MypageResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: MypageModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };
}

class MypageModel {
  final String? email;
  final String name;

  MypageModel({
    this.email,
    required this.name,
  });

  factory MypageModel.fromJson(Map<String, dynamic> json) {
    return MypageModel(
      email: json['email'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
  };
}
