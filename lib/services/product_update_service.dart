import 'package:dio/dio.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/model/product_update_model.dart';
import 'package:product_app/utils/app_preferences.dart';

class ProductUpdateService {
  final Dio _dio = Dio();
  Future<ProductUpdateModel?> productUpdate({
    String? name,
    int? id,
    String? mrp,
    String? selling,
    String? description,
    String? image,
  }) async {
    try {
      var data = {
        "name": name,
        "mrp": mrp,
        "selling": selling,
        "description": description,
        "image": image,
      };
      print(id);
      final Response response = await _dio.put(
          "${AppStrings.baseUrl}products/$id",
          data: data,
          options: Options(headers: {
            "Authorization":
                "Bearer ${AppPreference.getString(AppStrings.userToken)}"
          }));
      print(response.data);
      return ProductUpdateModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
