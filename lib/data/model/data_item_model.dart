// FILE: lib/models/data_item_model.dart
class DataItemModel {
  final String id;
  final String name;
  final String iconPath;
  final String type;
  final bool isActive;
  final double data1;
  final double data2;

  DataItemModel({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.type,
    required this.isActive,
    required this.data1,
    required this.data2,
  });

  factory DataItemModel.fromJson(Map<String, dynamic> json) {
    return DataItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      iconPath: json['iconPath'] ?? '',
      type: json['type'] ?? '',
      isActive: json['isActive'] ?? true,
      data1: (json['data1'] ?? 0).toDouble(),
      data2: (json['data2'] ?? 0).toDouble(),
    );
  }
}



class ElectricityModel {
  final double totalPower;
  final List<DataItemModel> sourceItems;
  final List<DataItemModel> loadItems;

  ElectricityModel({
    required this.totalPower,
    required this.sourceItems,
    required this.loadItems,
  });
}

// FILE: lib/models/menu_item_model.dart
class MenuItemModel {
  final String id;
  final String title;
  final String icon;
  final String route;

  MenuItemModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      route: json['route'] ?? '',
    );
  }
}
