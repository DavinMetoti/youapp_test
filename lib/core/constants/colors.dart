import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2EE4C6);         // Teal/Cyan - Main brand color
  static const Color primaryDark = Color(0xFF2F80ED);     // Blue - Secondary brand color
  static const Color primaryLight = Color(0xFF62F3E0);    // Lighter teal

  // Secondary Colors
  static const Color secondary = Color(0xFF2F80ED);       // Blue
  static const Color secondaryLight = Color(0xFF5A9BF5);  // Light blue
  static const Color accent = Color(0xFFFFD700);          // Gold/Yellow for accents

  // Background Colors
  static const Color background = Color(0xFF09141A);      // Dark navy - Main background
  static const Color backgroundLight = Color(0xFF162329); // Lighter dark background
  static const Color backgroundCard = Color(0xFF2A353C);  // Card background
  static const Color backgroundOverlay = Color(0xFF1A252A); // Overlay background

  // Text Colors
  static const Color textPrimary = Colors.white;         // Main text
  static const Color textSecondary = Color(0xFFB0B8C1);  // Secondary text (gray)
  static const Color textTertiary = Color(0xFF8A9BA8);   // Tertiary text (lighter gray)
  static const Color textHint = Color(0xFF6B7B88);       // Hint text
  static const Color textAmber = Color(0xFFFFD700);      // Amber accent text
  static const Color textGolden = Color(0xFFFFF1C0);     // Golden text

  // Surface Colors
  static const Color surface = Color(0xFF162329);        // Surface color
  static const Color surfaceLight = Color(0xFF2A353C);   // Light surface
  static const Color surfaceOverlay = Color(0xFF1F2A30); // Overlay surface

  // Interactive Colors
  static const Color buttonPrimary = Color(0xFF2EE4C6);  // Primary button
  static const Color buttonSecondary = Color(0xFF2F80ED); // Secondary button
  static const Color buttonDisabled = Color(0xFF3A4A52); // Disabled button

  // Status Colors
  static const Color success = Color(0xFF2EE4C6);        // Success state
  static const Color error = Color(0xFFE74C3C);          // Error state
  static const Color warning = Color(0xFFFFD700);        // Warning state
  static const Color info = Color(0xFF2F80ED);           // Info state

  // Border Colors
  static const Color borderPrimary = Color(0xFF3A4A52);  // Main border
  static const Color borderSecondary = Color(0xFF2A353C); // Secondary border
  static const Color borderLight = Color(0xFF4A5A62);    // Light border

  // Glassmorphism Colors
  static const Color glassBackground = Color(0x26FFFFFF); // White with 15% opacity
  static const Color glassBorder = Color(0x38FFFFFF);     // White with 22% opacity
  static const Color glassShadow = Color(0x1A000000);     // Black with 10% opacity

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF2EE4C6),
    Color(0xFF2F80ED),
  ];

  static const List<Color> primaryGradientDisabled = [
    Color(0x402EE4C6), // 25% opacity
    Color(0x402F80ED), // 25% opacity
  ];

  // White Variations (for consistency)
  static const Color white = Colors.white;
  static const Color white10 = Color(0x1AFFFFFF);        // 10% opacity
  static const Color white12 = Color(0x1FFFFFFF);        // 12% opacity
  static const Color white18 = Color(0x2EFFFFFF);        // 18% opacity
  static const Color white24 = Color(0x3DFFFFFF);        // 24% opacity
  static const Color white25 = Color(0x40FFFFFF);        // 25% opacity
  static const Color white38 = Color(0x61FFFFFF);        // 38% opacity
  static const Color white54 = Color(0x8AFFFFFF);        // 54% opacity
  static const Color white70 = Color(0xB3FFFFFF);        // 70% opacity
  static const Color white85 = Color(0xD9FFFFFF);        // 85% opacity
  static const Color white90 = Color(0xE6FFFFFF);        // 90% opacity

  // Black Variations
  static const Color black = Colors.black;
  static const Color black08 = Color(0x14000000);        // 8% opacity
  static const Color black10 = Color(0x1A000000);        // 10% opacity

  // Transparent
  static const Color transparent = Colors.transparent;

  // Theme-specific colors
  static const Color appBarBackground = Colors.transparent;
  static const Color scaffoldBackground = background;
  static const Color dialogBackground = backgroundLight;
  static const Color cardBackground = backgroundCard;
  static const Color inputFillColor = backgroundCard;
  static const Color dividerColor = borderSecondary;

  // Input field colors
  static const Color inputBorderColor = Color(0xFF3A4A52);
  static const Color inputFocusedBorderColor = white;
  static const Color inputHintColor = white70;
  static const Color inputTextColor = white;

  // Special colors for specific features
  static const Color horoscopeBackground = Color(0xFF2A353C);
  static const Color interestTagBackground = Color(0x1AFFFFFF);
  static const Color profileMenuBackground = Color(0xFF162329);
}