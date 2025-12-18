import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/empty_state_page.dart';
import '../../../data/model/data_item_model.dart';

import '../../scm_data/view/scm_data_view.dart';
import '../controller/dashboard_controller.dart';
import '../widget/circle_progress_bar.dart';


class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(
        title: 'SCM',
        showBackButton: true,
        showNotificationIcon: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _MainCard(),
              const SizedBox(height: 16),
              _MenuGrid(),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _MainCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _CustomTabBar(),
          _ElectricitySection(),
        ],
      ),
    );
  }

  Widget _CustomTabBar() {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TabBar(
              dividerColor: AppColors.borderColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textGrey,
              labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              tabs: const [Tab(text: "Summery"), Tab(text: "SLD"), Tab(text: "Data")],
            ),
          ),

        ],
      ),
    );
  }

  Widget _ElectricitySection() {
    final data = controller.electricityData.value;
    if (data == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        border: Border.fromBorderSide(BorderSide(color: AppColors.borderColor)),
      ),
      child: Column(
        children: [
          const Text('Electricity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
          const SizedBox(height: 20),
          const Divider(height: 1, color: AppColors.borderColor),
          const SizedBox(height: 20),
          _PowerCircle(data.totalPower),
          const SizedBox(height: 24),
          _SourceLoadToggle(),
          const SizedBox(height: 4),
          const Divider(thickness: 2, color: Color(0xFFA5A7B9)),
          const SizedBox(height: 8),
          _DataList(),
        ],
      ),
    );
  }

  Widget _PowerCircle(double power) {
    return SizedBox(
      width: 150,
      height: 150,
      child: CustomPaint(
        size: const Size(150, 150),
        painter: CircularProgressPainter(progress: 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Total Power', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textGrey)),
              const SizedBox(height: 8),
              Text('$power kW', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _SourceLoadToggle() {
    return Container(
      decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(30)),
      child: Row(children: [ _ToggleButton('Source'), _ToggleButton('Load')]),
    );
  }

  Widget _ToggleButton(String title) {
    final isSelected = controller.selectedSourceLoad.value == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectSourceLoad(title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(color: isSelected ? AppColors.primaryColor : Colors.transparent, borderRadius: BorderRadius.circular(30)),
          child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textGrey)),
        ),
      ),
    );
  }

  Widget _DataList() {
    final ScrollController scrollController = ScrollController();
    final data = controller.electricityData.value;
    if (data == null) return const SizedBox();

    final items = controller.selectedSourceLoad.value == 'Source' ? data.sourceItems : data.loadItems;

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            thickness: 5,
            radius: const Radius.circular(10),
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.only(top: 8, bottom: 16, right: 8),
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) => _DataCard(index, items[index]),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.11)]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _DataCard(int index, dynamic item) {
    final statusColor = item.isActive ? AppColors.activeBlue : AppColors.inactiveRed;
    final indicatorColor = index == 0 ? AppColors.primaryColor : index == 1 ? AppColors.orange : AppColors.primaryColor;

    return InkWell(
      onTap: () => Get.to(() => ScmDataView()),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: item.type == 'total' ? const Color(0x99DFE4E8) : const Color(0xFFE5F4FE),
          border: Border.all(color: const Color(0xFFA5A7B9)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Center(child: Image.asset(item.iconPath, height: 30, width: 30)),
            const SizedBox(width: 12),
            Expanded(child: _DataCardContent(item, indicatorColor, statusColor)),
            const Icon(Icons.chevron_right, color: AppColors.textGrey, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _DataCardContent(dynamic item, Color indicatorColor, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: indicatorColor, borderRadius: BorderRadius.circular(3))),
            const SizedBox(width: 8),
            Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(item.isActive ? '(Active)' : '(Inactive)', style: TextStyle(fontSize: 12, color: statusColor, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _DataRow('Data 1', item.data1),
        const SizedBox(height: 4),
        _DataRow('Data 2', item.data2),
      ],
    );
  }

  Widget _DataRow(String label, double value) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textGrey))),
        const Text(': ', style: TextStyle(color: AppColors.textGrey)),
        Expanded(flex: 2, child: Text(value.toStringAsFixed(2), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textDark))),
      ],
    );
  }

  Widget _MenuGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12, mainAxisSpacing: 10),
        itemCount: controller.menuItems.length,
        itemBuilder: (context, index) => _MenuItem(controller.menuItems[index]),
      ),
    );
  }

  Widget _MenuItem(MenuItemModel item) {
    return InkWell(
      onTap: () => Get.to(() => EmptyStateView()),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.borderColor)),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Center(child: Image.asset(item.icon, height: 30, width: 30)),
            const SizedBox(width: 8),
            Expanded(child: Text(item.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark))),
          ],
        ),
      ),
    );
  }
}
