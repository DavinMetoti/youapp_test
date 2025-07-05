import 'package:flutter/material.dart';
import 'package:youapp/features/profile/presentation/widgets/profile_card.dart';
class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          ProfileCardWidget(),
        ],
      ),
    );
  }
}