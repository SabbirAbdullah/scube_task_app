


import 'package:get/get.dart';
import 'package:scube_task_app/data/remote/dashboard_remote_data_impl.dart';

import '../../data/remote/auth_remote_data_impl.dart';
import '../../data/remote/auth_remote_data_source.dart';
import '../../data/remote/dashboard_remote_data_source.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(),
      tag: (AuthRemoteDataSource).toString(),
      fenix: true,
    );


    Get.lazyPut<DashboardLocalDataSource>(
          () => DashboardLocalDataSourceImpl(),
      tag: (DashboardLocalDataSource).toString(),
      fenix: true,
    );


  }

}
