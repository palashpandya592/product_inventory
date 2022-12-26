import 'package:dio/dio.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/model/home_screen_model.dart';
import 'package:product_app/utils/app_preferences.dart';

class HomeScreenService {
  final Dio _dio = Dio();
  int page = 1;
  static const int _perPage = 10;

  Future<HomeScreenModel?> fetchProductList() async {
    try {
      Response response = await _dio.get(
          '${AppStrings.baseUrl}products?page=$page&per_page=$_perPage',
          options: Options(headers: {
            "Authorization":
                "Bearer ${AppPreference.getString(AppStrings.userToken)}"
          }));
      page++;

      return HomeScreenModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return HomeScreenModel.withError("Data not found / Connection issue");
    }
  }
}
