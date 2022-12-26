import 'package:dio/dio.dart';
import 'package:product_app/constant/app_strings.dart';

import 'package:product_app/model/login_model.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<LoginModel?> userLogin({
    String? email,
    String? password,
  }) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };
    try {
      final Response response = await _dio.post(
        '${AppStrings.baseUrl}login',
        data: data,
      );
      return LoginModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
