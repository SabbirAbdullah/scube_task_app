import '../model/data_item_model.dart';

abstract class DashboardRepository {
  Future<ElectricityModel> getElectricityData();
  Future<List<MenuItemModel>> getMenuItems();
}
