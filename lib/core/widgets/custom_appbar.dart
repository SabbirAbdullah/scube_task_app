import 'package:flutter/material.dart';

import '../theme/app_colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showNotificationIcon;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    Key? key,
    this.title = 'SCM',
    this.showBackButton = true,
    this.showNotificationIcon = true,
    this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: showBackButton ? const BackButton(color: AppColors.textDark) : null,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.textDark, fontSize: 16,fontWeight: FontWeight.w500),
      ),
      actions: showNotificationIcon
          ? [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: onNotificationTap ?? () {},
            ),
            const Positioned(
              right: 12,
              top: 12,
              child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
            ),
          ],
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
