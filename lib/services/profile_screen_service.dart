import 'package:dio/dio.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/model/profile_user_model.dart';
import 'package:product_app/utils/app_preferences.dart';

class ProfileScreenService {
  final Dio _dio = Dio();

  Future<UserModel?> fetchUserList() async {
    try {
      Response response = await _dio.get('${AppStrings.baseUrl}getUserProfile',
          options: Options(headers: {
            "Authorization":
                "Bearer ${AppPreference.getString(AppStrings.userToken)}"
          }));
      return UserModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      return UserModel.withError("Data not found / Connection issue");
    }
  }
}
