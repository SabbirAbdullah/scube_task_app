import 'package:get/get.dart';

import '../../presentation/auth/binding/login_binding.dart';
import '../../presentation/auth/view/login_page.dart';
import '../../presentation/dashboard/binding/dashboard_binding.dart';
import '../../presentation/dashboard/view/dashboard_page.dart';
import '../../presentation/scm_data/binding/scm_binding.dart';
import '../../presentation/scm_data/view/scm_data_view.dart';

class AppPages {
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
  static const ENERGY = '/energy';
  static final routes = [
    GetPage(
        name: LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding()
    ),

    GetPage(
      name: DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),

    GetPage(
        name: ENERGY,
        page: () => ScmDataView(),
        binding: SCMBinding()
    ),
  ];
}
