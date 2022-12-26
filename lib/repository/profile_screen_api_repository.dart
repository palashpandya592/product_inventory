import 'package:product_app/services/profile_screen_service.dart';
import 'package:product_app/model/profile_user_model.dart';

class ProfileApiRepository {
  final _provider = ProfileScreenService();

  Future<UserModel?> fetchUserList() {
    return _provider.fetchUserList();
  }
}

class NetworkError extends Error {}
