import 'package:get/get.dart';

import '../../data/repository/auth_repository.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/dashboard_repository.dart';
import '../../data/repository/dashboard_repositoy_impl.dart';





class RepositoryBindings implements Bindings {

  @override
  void dependencies() {

    Get.lazyPut<AuthRepository>(
            () => AuthRepositoryImpl(),
        tag: (AuthRepository).toString(),
        fenix: true
    );


    Get.lazyPut<DashboardRepository>(
            () => DashboardRepositoryImpl(),
        tag: (DashboardRepository).toString(),
        fenix: true
    );


  }
}

