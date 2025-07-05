import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/common/widgets/badge.dart';

class ProfileCardWidget extends StatelessWidget {
  final String? email;
  final String? gender;
  final String? horoscope;
  final String? zodiac;

  const ProfileCardWidget({
    super.key,
    this.email,
    this.gender,
    this.horoscope,
    this.zodiac,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      padding: const EdgeInsets.all(12),
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (gender != null && gender!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 6),
                    child: Text(
                      gender!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Row(
                  children: [
                    if (horoscope != null && horoscope!.isNotEmpty)
                      BadgeWidget(icon: 'horoscope', label: horoscope!),
                    if (zodiac != null && zodiac!.isNotEmpty)
                      BadgeWidget(icon: 'zodiac', label: zodiac!),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
