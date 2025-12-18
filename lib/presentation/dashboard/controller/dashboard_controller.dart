import 'package:get/get.dart';
import '../../../data/model/data_item_model.dart';
import '../../../data/repository/dashboard_repository.dart';

class DashboardController extends GetxController {

  final DashboardRepository _repository =
  Get.find(tag: (DashboardRepository).toString());

  final RxString selectedTab = 'Summery'.obs;
  final RxString selectedSourceLoad = 'Source'.obs;
  final RxBool isLoading = true.obs;
  final Rx<ElectricityModel?> electricityData = Rx<ElectricityModel?>(null);
  final RxList<MenuItemModel> menuItems = <MenuItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;

      final data = await _repository.getElectricityData();
      final menu = await _repository.getMenuItems();

      electricityData.value = data;
      menuItems.value = menu;

    } catch (e) {
      Get.snackbar('Error', 'Failed to load data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectTab(String tab) => selectedTab.value = tab;

  void selectSourceLoad(String type) => selectedSourceLoad.value = type;

  void onMenuItemTap(MenuItemModel item) => Get.snackbar('Navigation', 'Opening ${item.title}');

  void onDataItemTap(String itemName) => Get.snackbar('Data Item', 'Selected: $itemName');
}



