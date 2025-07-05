import 'package:flutter/material.dart';
import 'package:youapp/common/widgets/logout_dialog.dart';
import 'package:youapp/core/constants/colors.dart';

void showProfileMenu(BuildContext context) async {
  final button = context.findRenderObject() as RenderBox;
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);

  final result = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy + button.size.height,
      overlay.size.width - position.dx - button.size.width,
      overlay.size.height - position.dy - button.size.height,
    ),
    items: [
      PopupMenuItem(
        value: 'logout',
        child: Row(
          children: [
            Icon(Icons.logout, color: AppColors.white),
            const SizedBox(width: 8),
            const Text('Logout', style: TextStyle(color: AppColors.white)),
          ],
        ),
      ),
    ],
    color: AppColors.backgroundLight,
  );

  if (result == 'logout') {
    showLogoutDialog(context);
  }
}
