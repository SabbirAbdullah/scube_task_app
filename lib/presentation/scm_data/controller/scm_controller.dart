import 'package:get/get.dart';




class SCMController extends GetxController{
   ///DATA View
  void switchDate(String type) {
    selectedDateType.value = type;
  }
  RxString selectedDateType = 'Today'.obs;
  final selectedView = 'Data'.obs;

  final List<Map<String, dynamic>> chart1 = [
  {'label': 'Data A', 'value': 2798.50, 'percent': '29.53%', 'cost': '35689 ৳', 'color': 0xFF0085FF},
  {'label': 'Data B', 'value': 72598.50, 'percent': '35.39%', 'cost': '5259689 ৳', 'color': 0xFF6AD1FF},
  {'label': 'Data C', 'value': 6598.36, 'percent': '83.90%', 'cost': '5698756 ৳', 'color': 0xFF8E44FF},
  {'label': 'Data D', 'value': 6598.26, 'percent': '36.59%', 'cost': '356987 ৳', 'color': 0xFFFF9800},
  ];

  void switchView(String v) => selectedView.value = v;

  /// Gauge value based on selection
  double get gaugeValue =>
      selectedDateType.value == 'Today' ? 55.0 : 57.0;

  /// Gauge progress (0.0 - 1.0)
  double get gaugeProgress =>
      selectedDateType.value == 'Today' ? 0.55 : 0.57;



  /// Revenue view

  RxString selectedRevenueView = 'Revenue'.obs;

  /// Revenue gauge values (static)
  final double revenueValue = 8897455;
  final double revenueProgress = 0.78;

  /// Expand / collapse
  RxBool isExpanded = true.obs;

  /// Static revenue data
  final List<Map<String, dynamic>> revenueList = [
  {'label': 'Data 1', 'value': '2798.50 (29.53%)', 'cost': '35689 ৳'},
  {'label': 'Data 2', 'value': '2798.50 (29.53%)', 'cost': '35689 ৳'},
  {'label': 'Data 3', 'value': '2798.50 (29.53%)', 'cost': '35689 ৳'},
  {'label': 'Data 4', 'value': '2798.50 (29.53%)', 'cost': '35689 ৳'},
  ];

  void toggleExpand() {
  isExpanded.toggle();
  }

  }


