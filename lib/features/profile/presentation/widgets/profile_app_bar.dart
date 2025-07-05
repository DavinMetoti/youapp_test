import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/common/utils/menu_helper.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBackground,
      elevation: 0,
      title: Text(
        "user@example.com",
        style: const TextStyle(color: AppColors.white, fontSize: 14),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.white),
            onPressed: () => showProfileMenu(context),
          ),
        ),
      ],
    );
  }
}
