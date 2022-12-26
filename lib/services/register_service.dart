import 'package:dio/dio.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/model/register_model.dart';

class RegisterService {
  final Dio _dio = Dio();

  Future<RegisterModel?> userRegister({
    String? name,
    String? email,
    String? password,
    String? password_confirmation,
    String? birth_date,
    String? gender,
    String? image,
  }) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": password_confirmation,
      "birth_date": birth_date,
      "gender": gender,
      "image": image,
    };
    try {
      final Response response =
          await _dio.post("${AppStrings.baseUrl}register", data: data);
      return RegisterModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
