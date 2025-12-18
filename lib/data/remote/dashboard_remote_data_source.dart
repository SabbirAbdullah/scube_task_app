abstract class DashboardLocalDataSource {
  Future<Map<String, dynamic>> getElectricityData();
  Future<List<Map<String, dynamic>>> getMenuItems();
}
