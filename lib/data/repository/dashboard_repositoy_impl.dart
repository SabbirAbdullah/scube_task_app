

import 'package:get/get.dart';

import '../model/data_item_model.dart';
import '../remote/dashboard_remote_data_source.dart';
import 'dashboard_repository.dart';


class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource remoteDataSource =
  Get.find(tag: (DashboardLocalDataSource).toString());


  Future<ElectricityModel> getElectricityData() async {
    final data = await remoteDataSource.getElectricityData();

    final sourceItems = (data['sourceItems'] as List)
        .map((e) => DataItemModel.fromJson(e))
        .toList();

    final loadItems = (data['loadItems'] as List)
        .map((e) => DataItemModel.fromJson(e))
        .toList();

    return ElectricityModel(
      totalPower: data['totalPower'],
      sourceItems: sourceItems,
      loadItems: loadItems,
    );
  }

  Future<List<MenuItemModel>> getMenuItems() async {
    final items = await remoteDataSource.getMenuItems();
    return items.map((e) => MenuItemModel.fromJson(e)).toList();
  }
}