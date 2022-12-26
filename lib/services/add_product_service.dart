import 'package:dio/dio.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/model/add_product_model.dart';
import 'package:product_app/utils/app_preferences.dart';

class AddProductService {
  final Dio _dio = Dio();

  Future<AddProductModel?> addProduct({
    String? name,
    String? mrp,
    String? selling,
    String? description,
    String? image,
  }) async {
    Map<String, dynamic> data = {
      "name": name,
      "mrp": mrp,
      "selling": selling,
      "description": description,
      "image": image,
    };
    try {
      final Response response = await _dio.post("${AppStrings.baseUrl}products",
          data: data,
          options: Options(headers: {
            "Authorization":
                "Bearer ${AppPreference.getString(AppStrings.userToken)}"
          }));
      print(response.data);
      return AddProductModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
