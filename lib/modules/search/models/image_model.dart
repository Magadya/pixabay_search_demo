class ImageModel {
  final int id;
  final String webFormatURL;
  final String previewURL;
  final int likes;
  final int views;

  ImageModel({required this.id, required this.webFormatURL,required this.previewURL, required this.likes, required this.views});

  static List<ImageModel> listFromJson(List<dynamic> list) {
    return list.map((dynamic json) => ImageModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as int,
      webFormatURL: json['webformatURL'] as String,
      previewURL:json['previewURL'] as String,
      likes: json['likes'] as int,
      views: json['views'] as int,
    );
  }
}
