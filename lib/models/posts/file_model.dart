class FileModel {
  final String file;
  final String caption;

  FileModel({
    required this.file,
    required this.caption,
  });

  factory FileModel.copyWith(dynamic map) => FileModel(
        file: map['file'],
        caption: map['caption'],
      );
}
