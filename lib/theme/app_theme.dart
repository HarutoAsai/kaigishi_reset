import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color seed = const Color(0xFF3E6AE1); // 海色ベース

ThemeData buildAppTheme(Brightness brightness) {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: brightness),
    useMaterial3: true,
  );

  return base.copyWith(
    textTheme: GoogleFonts.notoSansJpTextTheme(base.textTheme),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: GoogleFonts.notoSansJp(
        fontSize: 20, fontWeight: FontWeight.w700, color: base.colorScheme.onSurface,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      surfaceTintColor: Colors.transparent,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );
}
