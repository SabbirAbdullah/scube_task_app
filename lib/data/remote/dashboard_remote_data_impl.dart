// FILE: lib/data/dashboard_local_datasource.dart


import 'dashboard_remote_data_source.dart';

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  @override
  Future<Map<String, dynamic>> getElectricityData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'totalPower': 5.53,
      'sourceItems': [
        {'id': '1', 'name': 'Data View', 'iconPath': 'assets/data1.png', 'type': 'solar', 'isActive': true, 'data1': 55505.63, 'data2': 58805.63},
        {'id': '2', 'name': 'Data Type 2', 'iconPath': 'assets/data2.png', 'type': 'battery', 'isActive': true, 'data1': 55505.63, 'data2': 58805.63},
        {'id': '3', 'name': 'Data Type 3', 'iconPath': 'assets/data3.png', 'type': 'grid', 'isActive': false, 'data1': 55505.63, 'data2': 58805.63},
        {'id': '4', 'name': 'Total Solar', 'iconPath': 'assets/data1.png', 'type': 'total', 'isActive': true, 'data1': 55505.63, 'data2': 58805.63},

      ],
      'loadItems': [
        {'id': '1', 'name': 'Data View', 'iconPath': 'assets/data1.png', 'type': 'solar', 'isActive': true, 'data1': 55505.63, 'data2': 58805.63},
        {'id': '2', 'name': 'Data Type 2', 'iconPath': 'assets/data2.png', 'type': 'battery', 'isActive': true, 'data1': 55505.63, 'data2': 58805.63},
        {'id': '3', 'name': 'Data Type 3', 'iconPath': 'assets/data3.png', 'type': 'grid', 'isActive': false, 'data1': 55505.63, 'data2': 58805.63},
        {'id': '1', 'name': 'Total Solar', 'iconPath': 'assets/data1.png', 'type': 'total', 'isActive': true, 'data1': 55505.63, 'data2': 58805.63},

      ],
    };
  }

  @override
  Future<List<Map<String, dynamic>>> getMenuItems() async {
    return [
      {'id': '1', 'title': 'Analysis Pro', 'icon': 'assets/analyze.png', 'route': '/analysis'},
      {'id': '2', 'title': 'G. Generator', 'icon': 'assets/generator.png', 'route': '/generator'},
      {'id': '3', 'title': 'Plant Summery', 'icon': 'assets/plant.png', 'route': '/plant'},
      {'id': '4', 'title': 'Natural Gas', 'icon': 'assets/gas.png', 'route': '/gas'},
      {'id': '5', 'title': 'D. Generator', 'icon': 'assets/generator.png', 'route': '/dgenerator'},
      {'id': '6', 'title': 'Water Process', 'icon': 'assets/watar.png', 'route': '/water'},
    ];
  }
}
