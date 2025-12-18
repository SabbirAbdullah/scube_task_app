import 'package:get/get.dart';

import '../controller/scm_controller.dart';



class SCMBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SCMController());
  }
}