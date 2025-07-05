import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:youapp/common/services/secure_storage_service.dart';
import 'package:youapp/features/auth/presentation/pages/login.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (ctx) => const LogoutDialog(),
  );
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.15),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, color: Colors.white, size: 44),
                const SizedBox(height: 18),
                const Text('Logout Confirmation', style: TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(height: 10),
                const Text('Are you sure you want to logout?', style: TextStyle(color: Colors.white70, fontSize: 15)),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _handleLogout(context),
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    final storage = SecureStorageService();
    await storage.deleteToken();
    Navigator.of(context).pop();
    Get.offAll(() => const LoginPage());
  }
}
