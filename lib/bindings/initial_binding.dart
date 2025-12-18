import 'package:get/get.dart';
import 'package:scube_task_app/bindings/remote_source_binding.dart';
import 'package:scube_task_app/bindings/repository_binding.dart';

import '../core/network/dio_client.dart';




class InitialBinding extends Bindings {


  @override
  void dependencies() {
    // Network
    Get.lazyPut(() => DioClient(), fenix: true);
    //repository
    RepositoryBindings().dependencies();

    //remote
    RemoteSourceBindings().dependencies();




  }
}




