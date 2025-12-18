import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../controller/scm_controller.dart';
import '../widget/gauge_painter.dart';

class ScmDataView extends StatelessWidget {
  ScmDataView({super.key});

  // Controller instance
  final SCMController controller = Get.put(SCMController());

  // Constants
  static const double mainContainerTopMargin = 40;
  static const double gaugeHeight = 130;
  static const double gaugeWidth = 160;
  static const double cardPadding = 8;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(
        title: 'SCM',
        showBackButton: true,
        showNotificationIcon: true,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _mainContainer(isTablet),
          Positioned(top: -5, left: 12, right: 12, child: _viewToggle()),
        ],
      ),
    );
  }

  /// Main white container
  Widget _mainContainer(bool isTablet) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(top: mainContainerTopMargin),
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Obx(() {
          return controller.selectedView.value == 'Data'
              ? _dataViewContent(isTablet)
              : _revenueViewContent(isTablet);
        }),
      ),
    );
  }

  /// Data View Content
  Widget _dataViewContent(bool isTablet) {
    final isToday = controller.selectedDateType.value == 'Today';

    return Column(
      children: [
        const SizedBox(height: 24),
        Obx(() => _gauge(isTablet, controller.gaugeValue, controller.gaugeProgress)),
        const SizedBox(height: 24),
        _dateToggle(),
        const SizedBox(height: 12),
        if (!isToday) ...[_dateInputs(), const SizedBox(height: 24)],
        _energyCard("Energy Chart", "20.05 kw"),
        if (!isToday) ...[
          const SizedBox(height: 16),
          _energyCard("Energy Chart", "5.53 kw"),
        ],
      ],
    );
  }

  /// Revenue View Content
  Widget _revenueViewContent(bool isTablet) {
    return Column(
      children: [
        const SizedBox(height: 24),
        _revenueGauge(),
        const SizedBox(height: 32),
        _dataCostInfo(),
      ],
    );
  }

  /// Revenue Gauge
  Widget _revenueGauge() {
    return SizedBox(
      height: 200,
      width: 200,
      child: CustomPaint(
        painter: GaugePainter(controller.revenueProgress),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.revenueValue.toString(),
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("tk", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  /// Data & Cost Info Section
  Widget _dataCostInfo() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: controller.toggleExpand,
              child: Row(

                children: [
                  const Icon(Icons.bar_chart, color: AppColors.textGrey),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text("Data & Cost Info",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      controller.isExpanded.value
                          ? Icons.keyboard_double_arrow_up
                          : Icons.keyboard_double_arrow_down,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            if (controller.isExpanded.value) ...[
              const SizedBox(height: 16),
              ...controller.revenueList.map(_revenueRow),
            ],
          ],
        ),
      );
    });
  }

  Widget _revenueRow(Map<String, dynamic> e) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _labeledValue(e['label'], e['value']),
          const SizedBox(height: 6),
          _labeledValue("Cost", e['cost']),
        ],
      ),
    );
  }

  Widget _labeledValue(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16),
        children: [
          TextSpan(text: "$label : ", style: const TextStyle(color: AppColors.textGrey)),
          TextSpan(text: value, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  /// Toggle between Data and Revenue views
  Widget _viewToggle() {
    final views = ['Data View', 'Revenue View'];
    return Obx(
          () => Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: views.map((e) {
            final selected = controller.selectedView.value == e.split(' ')[0];
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.switchView(e.split(' ')[0]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off,
                        color: selected ? AppColors.primaryColor : AppColors.textGrey),
                    const SizedBox(width: 8),
                    Text(e,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: selected ? AppColors.primaryColor : AppColors.textGrey)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Gauge Widget
  Widget _gauge(bool isTablet, double value, double progress) {
    final size = isTablet ? 260.0 : 150.0;
    return SizedBox(
      height: gaugeHeight,
      width: gaugeWidth,
      child: CustomPaint(
        size: Size(size, size),
        painter: GaugePainter(progress),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value.toStringAsFixed(0), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text("kWh/Sqft", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  /// Date Toggle
  Widget _dateToggle() {
    final labels = ['Today Data', 'Custom Date Data'];
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: labels.map((label) => Padding(
          padding: const EdgeInsets.only(right: 24),
          child: _radio(label),
        )).toList(),
      ),
    );
  }

  Widget _radio(String label) {
    final selected = controller.selectedDateType.value == label.split(' ')[0];
    return GestureDetector(
      onTap: () => controller.switchDate(label.split(' ')[0]),
      child: Row(
        children: [
          Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.primaryColor : AppColors.textGrey),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: selected ? AppColors.primaryColor : AppColors.textGrey, fontSize: 14)),
        ],
      ),
    );
  }

  /// Date Inputs
  Widget _dateInputs() {
    return Row(
      children: [
        _dateBox("From Date"),
        const SizedBox(width: 12),
        _dateBox("To Date"),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xFFE2EBF1),
            border: Border.all(color: AppColors.primaryColor,),
          ),
          child: const Icon(Icons.search, color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Widget _dateBox(String title) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16,color: Colors.black45)),
          const Icon(Icons.calendar_today_outlined),
        ],
      ),
    ),
  );

  /// Energy Card
  Widget _energyCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          ...controller.chart1.map(_dataRow),
        ],
      ),
    );
  }

  /// Data Row in Energy Card
  Widget _dataRow(Map<String, dynamic> e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 10, height: 10, decoration: BoxDecoration(color: Color(e['color']), shape: BoxShape.circle)),
                const SizedBox(height: 6),
                Text(e['label'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
            const VerticalDivider(color: AppColors.border, thickness: 1, width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _labeledValue("Data", "${e['value']} (${e['percent']})"),
                  const SizedBox(height: 4),
                  _labeledValue("Cost", e['cost']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

