import '../../../core/network/dio_client.dart';
import '../model/user_model.dart';
import 'auth_remote_data_source.dart';



class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient = DioClient();

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // mock success
  }
}
