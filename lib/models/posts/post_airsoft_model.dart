import 'package:simple_crud_getx_airsoft_api/models/_models.dart';

class PostAirsoftModel {
  final bool success;
  final String message;
  final AirsoftModel data;

  PostAirsoftModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PostAirsoftModel.fromMap(dynamic map) {
    dynamic data;
    if (map['data'] != null) {
      data = AirsoftModel.fromMap(map['data']);
    }

    return PostAirsoftModel(
      success: map['success'],
      message: map['message'],
      data: data,
    );
  }
}
