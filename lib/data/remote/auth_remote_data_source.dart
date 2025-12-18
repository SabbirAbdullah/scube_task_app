import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> login(String username, String password);

}