import 'image_model.dart';

class SearchResultModel {
  final int totalHits;
  final List<ImageModel>? images;
  final int total;

  SearchResultModel({
    required this.totalHits,
    required this.images,
    required this.total,
  });

  static List<SearchResultModel> listFromJson(List<dynamic> list) {
    return list.map((dynamic json) => SearchResultModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      totalHits: json['totalHits'] as int,
      images: json['hits'] != null
          ? (json['hits'] as List).map((dynamic i) => ImageModel.fromJson(i as Map<String, dynamic>)).toList()
          : null,
      total: json['total'] as int,
    );
  }
}
