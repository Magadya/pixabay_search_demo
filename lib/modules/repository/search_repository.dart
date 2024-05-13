import 'package:pixabay_search_demo/modules/search/models/image_model.dart';
import 'package:pixabay_search_demo/networking/api_services/pixabay_api_service.dart';

class SearchRepository {

  Future<List<ImageModel>?> getImagesWithSearchQuery(String? query,int page) =>
      PixabayApiService.getImagesWithSearchQuery(query,page);
}