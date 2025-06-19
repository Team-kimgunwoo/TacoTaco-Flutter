class EmotionModel {
  int status;
  String message;
  EmotionData data;

  EmotionModel({
    this.status = 0,
    this.message = '',
    EmotionData? data,
  }) : data = data ?? EmotionData();

  factory EmotionModel.fromJson(Map<String, dynamic> json) {
    return EmotionModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: EmotionData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };
}

class EmotionData {
  String emotionType;
  String? modifiedDate;

  EmotionData({
    this.emotionType = '',
    this.modifiedDate,
  });

  factory EmotionData.fromJson(Map<String, dynamic> json) {
    return EmotionData(
      emotionType: json['emotionType'] ?? '',
      modifiedDate: json['modifiedDate'],
    );
  }

  Map<String, dynamic> toJson() => {
    'emotionType': emotionType,
    'modifiedDate': modifiedDate,
  };
}
