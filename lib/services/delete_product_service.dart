import 'package:dio/dio.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/model/delete_product_model.dart';
import 'package:product_app/utils/app_preferences.dart';

class DeleteProductService {
  final Dio _dio = Dio();

  Future<DeleteProductModel?> deleteProduct({
    int? id,
  }) async {
    try {
      var data = {};
      print(id);
      final Response response = await _dio.delete(
          "${AppStrings.baseUrl}products/$id",
          data: data,
          options: Options(headers: {
            "Authorization":
                "Bearer ${AppPreference.getString(AppStrings.userToken)}"
          }));
      return DeleteProductModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
