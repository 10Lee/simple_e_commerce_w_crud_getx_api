import '../_models.dart';

class UploadModel {
  final bool success;
  final String message;

  final FileModel data;

  UploadModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UploadModel.fromMap(dynamic map) {
    dynamic data;
    if (map['data'] != null) {
      data = FileModel.copyWith(map['data']);
    }
    return UploadModel(
      success: map['success'],
      message: map['message'],
      data: data,
    );
  }
}
