import 'package:dio/dio.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/model/user_update_model.dart';
import 'package:product_app/utils/app_preferences.dart';

class UpdateService {
  final Dio _dio = Dio();
  Future<UserUpdateModel?> userUpdate({
    String? name,
    int? id,
    String? email,
    String? birth_date,
  }) async {
    try {
      var data = {
        "name": name,
        "email": email,
        "birth_date": birth_date,
      };
      print(id);
      final Response response = await _dio.put(
          "${AppStrings.baseUrl}profileUpdate/$id",
          data: data,
          options: Options(headers: {
            "Authorization":
                "Bearer ${AppPreference.getString(AppStrings.userToken)}"
          }));
      print(response.data);
      return UserUpdateModel.fromJson(response.data);
    } catch (e) {
      // print(e);
    }
    return null;
  }
}
