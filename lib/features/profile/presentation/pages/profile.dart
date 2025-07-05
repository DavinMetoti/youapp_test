import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:youapp/features/profile/presentation/widgets/profile_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      backgroundColor: AppColors.background,
      body: const ProfileBody(),
    );
  }
}
