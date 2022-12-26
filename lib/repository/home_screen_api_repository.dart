import 'package:product_app/model/home_screen_model.dart';
import 'package:product_app/services/home_screen_service.dart';

class HomeApiRepository {
  final _provider = HomeScreenService();
  int? page;

  Future<HomeScreenModel?> fetchProductList({int? page}) {
    return _provider.fetchProductList();
  }
}

class HomeNetworkError extends Error {}
