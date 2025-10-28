import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0035ca),
      surfaceTint: Color(0xff0345fc),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1049ff),
      onPrimaryContainer: Color(0xffd8dcff),
      secondary: Color(0xff4758ab),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff95a6ff),
      onSecondaryContainer: Color(0xff25388a),
      tertiary: Color(0xff7d009d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9e1cc3),
      onTertiaryContainer: Color(0xfffad0ff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff191b25),
      onSurfaceVariant: Color(0xff434657),
      outline: Color(0xff747688),
      outlineVariant: Color(0xffc4c5da),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e303a),
      inversePrimary: Color(0xffb9c3ff),
      primaryFixed: Color(0xffdee1ff),
      onPrimaryFixed: Color(0xff001258),
      primaryFixedDim: Color(0xffb9c3ff),
      onPrimaryFixedVariant: Color(0xff0032c2),
      secondaryFixed: Color(0xffdee1ff),
      onSecondaryFixed: Color(0xff001258),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff2e3f92),
      tertiaryFixed: Color(0xfffcd7ff),
      onTertiaryFixed: Color(0xff340043),
      tertiaryFixedDim: Color(0xfff2afff),
      onTertiaryFixedVariant: Color(0xff780097),
      surfaceDim: Color(0xffd9d9e7),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f2ff),
      surfaceContainer: Color(0xffedecfb),
      surfaceContainerHigh: Color(0xffe7e7f5),
      surfaceContainerHighest: Color(0xffe2e1ef),
    );
  }


  ThemeData light() {
    return theme(lightScheme()).copyWith(
      scaffoldBackgroundColor: Color(0xffF5F5FA),

      /// TEXT
      textTheme: const TextTheme().copyWith(
        displayLarge: const TextStyle().copyWith(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        displayMedium: const TextStyle().copyWith(
          fontSize: 34,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        displaySmall: const TextStyle().copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),

        headlineLarge: const TextStyle().copyWith(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        headlineMedium: const TextStyle().copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        headlineSmall: const TextStyle().copyWith(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),

        titleLarge: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        titleMedium: const TextStyle().copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        titleSmall: const TextStyle().copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),

        labelLarge: const TextStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        labelMedium: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        labelSmall: const TextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),

        bodyLarge: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        bodyMedium: const TextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
        bodySmall: const TextStyle().copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontFamily: 'Capriola',
        ),
      ),

      /// TEXT INPUT FIELDS DECORATION
      inputDecorationTheme: const InputDecorationTheme().copyWith(
        prefixIconColor: Colors.black,
        suffixIconColor: Colors.black,
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontFamily: "Capriola",
          fontSize: 16,
        ),
        hintStyle: const TextStyle().copyWith(fontSize: 14, fontFamily: "Capriola", color: Colors.grey[700]),
        filled: true,
        fillColor: Color(0x73c7c7c9),
        floatingLabelStyle: const TextStyle().copyWith(
          fontSize: 16,fontFamily: "Capriola",
          color: Colors.black.withValues(alpha: 0.8),
        ),
        border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: MaterialTheme.lightScheme().primary,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        errorMaxLines: 3,
        errorStyle: TextStyle(color: Color(0xffff5f5f), fontFamily: "Capriola", fontWeight: FontWeight.w700),
      ),

      /// APPBAR
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actionsIconTheme: const IconThemeData(color: Colors.black, size: 27),
        iconTheme: IconThemeData(color: MaterialTheme.lightScheme().primary),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),

      /// CARDS
      cardTheme: const CardThemeData().copyWith(
        color: lightScheme().surfaceContainerLowest,
        shadowColor: Colors.black,
      ),

      /// BTM SHEET
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: Colors.black,
        modalBackgroundColor: const Color(0xfff3fbff),
        showDragHandle: true,
        dragHandleColor: Colors.black,
        dragHandleSize: const Size(100, 6),
        constraints: const BoxConstraints(minWidth: double.infinity),
      ),

      /// CHECKBOXES
      checkboxTheme: const CheckboxThemeData().copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          } else {
            return Colors.black;
          }
        }),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return MaterialTheme.lightScheme().primary;
          } else {
            return Colors.transparent;
          }
        }),
      ),

      /// CHIPS
      chipTheme: const ChipThemeData().copyWith(
        disabledColor: Colors.grey,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
        selectedColor: MaterialTheme.lightScheme().primary,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        checkmarkColor: Colors.white,
      ),

      /// ELEVATED BTNS
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          foregroundColor: Colors.white,
          backgroundColor: MaterialTheme.lightScheme().primary,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Capriola',
          ),
        ),
      ),

      /// OUTLINED BTNS
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MaterialTheme.lightScheme().primary,
          side: BorderSide(color: MaterialTheme.lightScheme().primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Capriola',
          ),
        ),
      ),

      /// TEXT BTNS
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MaterialTheme.lightScheme().primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Capriola',
          ),
        ),
      ),

      /// ICON BTNS
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: MaterialTheme.lightScheme().primary,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      /// FLOATING ACTION BTN
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MaterialTheme.lightScheme().primary,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      /// NAVIGATION BAR
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: MaterialTheme.lightScheme().surface,
        indicatorColor: MaterialTheme.lightScheme().primaryContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        height: 80,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Capriola',
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontFamily: 'Capriola',
          );
        }),
      ),

      /// DRAWER
      drawerTheme: DrawerThemeData(
        backgroundColor: MaterialTheme.lightScheme().surface,
        surfaceTintColor: Colors.transparent,
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),

      /// LIST TILES
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selectedTileColor: MaterialTheme.lightScheme().primaryContainer,
        selectedColor: MaterialTheme.lightScheme().onPrimaryContainer,
        textColor: MaterialTheme.lightScheme().onSurface,
        iconColor: MaterialTheme.lightScheme().onSurfaceVariant,
      ),

      /// RADIO BUTTONS
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return MaterialTheme.lightScheme().primary;
          }
          return MaterialTheme.lightScheme().outline;
        }),
      ),

      /// SWITCHES
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return MaterialTheme.lightScheme().onPrimary;
          }
          return MaterialTheme.lightScheme().outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return MaterialTheme.lightScheme().primary;
          }
          return MaterialTheme.lightScheme().surfaceContainerHighest;
        }),
      ),

      /// SLIDERS
      sliderTheme: SliderThemeData(
        activeTrackColor: MaterialTheme.lightScheme().primary,
        inactiveTrackColor: MaterialTheme.lightScheme().surfaceContainerHighest,
        thumbColor: MaterialTheme.lightScheme().primary,
        overlayColor: MaterialTheme.lightScheme().primary.withValues(alpha: 0.1),
        trackHeight: 4,
      ),

      /// PROGRESS INDICATORS
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: MaterialTheme.lightScheme().primary,
        linearTrackColor: MaterialTheme.lightScheme().surfaceContainerHighest,
        circularTrackColor: MaterialTheme.lightScheme().surfaceContainerHighest,
      ),

      /// TABS
      tabBarTheme: TabBarThemeData(
        labelColor: MaterialTheme.lightScheme().primary,
        unselectedLabelColor: MaterialTheme.lightScheme().onSurfaceVariant,
        indicatorColor: MaterialTheme.lightScheme().primary,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Capriola',
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'Capriola',
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      /// TOOLTIPS
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: MaterialTheme.lightScheme().inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: MaterialTheme.lightScheme().onInverseSurface,
          fontSize: 14,
          fontFamily: 'Capriola',
        ),
      ),

      /// SNACKBAR
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MaterialTheme.lightScheme().inverseSurface,
        contentTextStyle: TextStyle(
          color: MaterialTheme.lightScheme().onInverseSurface,
          fontSize: 14,
          fontFamily: 'Capriola',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      /// DIVIDER
      dividerTheme: DividerThemeData(
        color: MaterialTheme.lightScheme().outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb9c3ff),
      surfaceTint: Color(0xffb9c3ff),
      onPrimary: Color(0xff00228b),
      primaryContainer: Color(0xff1049ff),
      onPrimaryContainer: Color(0xffd8dcff),
      secondary: Color(0xffb9c3ff),
      onSecondary: Color(0xff12277a),
      secondaryContainer: Color(0xff2e3f92),
      onSecondaryContainer: Color(0xffa2b1ff),
      tertiary: Color(0xfff2afff),
      onTertiary: Color(0xff55006c),
      tertiaryContainer: Color(0xff9e1cc3),
      onTertiaryContainer: Color(0xfffad0ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff11131c),
      onSurface: Color(0xffe2e1ef),
      onSurfaceVariant: Color(0xffc4c5da),
      outline: Color(0xff8e8fa3),
      outlineVariant: Color(0xff434657),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e1ef),
      inversePrimary: Color(0xff0345fc),
      primaryFixed: Color(0xffdee1ff),
      onPrimaryFixed: Color(0xff001258),
      primaryFixedDim: Color(0xffb9c3ff),
      onPrimaryFixedVariant: Color(0xff0032c2),
      secondaryFixed: Color(0xffdee1ff),
      onSecondaryFixed: Color(0xff001258),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff2e3f92),
      tertiaryFixed: Color(0xfffcd7ff),
      onTertiaryFixed: Color(0xff340043),
      tertiaryFixedDim: Color(0xfff2afff),
      onTertiaryFixedVariant: Color(0xff780097),
      surfaceDim: Color(0xff11131c),
      surfaceBright: Color(0xff373843),
      surfaceContainerLowest: Color(0xff0c0e17),
      surfaceContainerLow: Color(0xff191b25),
      surfaceContainer: Color(0xff1d1f29),
      surfaceContainerHigh: Color(0xff282934),
      surfaceContainerHighest: Color(0xff33343f),
    );
  }


  ThemeData dark() {
    return theme(darkScheme()).copyWith(
      scaffoldBackgroundColor: darkScheme().surface,

      /// TEXT
      textTheme: const TextTheme().copyWith(
        displayLarge: const TextStyle().copyWith(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        displayMedium: const TextStyle().copyWith(
          fontSize: 34,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        displaySmall: const TextStyle().copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),

        headlineLarge: const TextStyle().copyWith(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        headlineMedium: const TextStyle().copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        headlineSmall: const TextStyle().copyWith(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),

        titleLarge: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        titleMedium: const TextStyle().copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        titleSmall: const TextStyle().copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),

        labelLarge: const TextStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        labelMedium: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        labelSmall: const TextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),

        bodyLarge: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        bodyMedium: const TextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
        bodySmall: const TextStyle().copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontFamily: 'Capriola',
        ),
      ),

      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 27),
        iconTheme: IconThemeData(color: MaterialTheme.darkScheme().primary),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      cardTheme: const CardThemeData().copyWith(
        color: darkScheme().surfaceContainer,
        shadowColor: Colors.white,
      ),

      chipTheme: const ChipThemeData().copyWith(
        disabledColor: Colors.grey,
        labelStyle: const TextStyle(color: Colors.white),
        selectedColor: MaterialTheme.darkScheme().primary,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        checkmarkColor: Colors.white,
      ),

      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: MaterialTheme.darkScheme().surfaceContainerLow,
        showDragHandle: true,
        dragHandleColor: Colors.grey,
        dragHandleSize: const Size(100, 6),
        constraints: const BoxConstraints(minWidth: double.infinity),
      ),

      checkboxTheme: const CheckboxThemeData().copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          } else {
            return Colors.white;
          }
        }),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return MaterialTheme.darkScheme().primaryContainer;
          } else {
            return Colors.transparent;
          }
        }),
      ),


      inputDecorationTheme: const InputDecorationTheme().copyWith(
        prefixIconColor: Colors.white,
        suffixIconColor: Colors.white,
        labelStyle: const TextStyle().copyWith(
          fontSize: 16, fontFamily: "Capriola",
          color: Colors.grey[300],
          fontWeight: FontWeight.normal,
        ),
        hintStyle: const TextStyle().copyWith(fontSize: 14, fontFamily: "Capriola", color: Colors.grey[300]),
        floatingLabelStyle: const TextStyle().copyWith(
          fontSize: 16, fontFamily: "Capriola",
          color: Colors.white.withValues(alpha: 0.8),
        ),
        filled: true,
        fillColor: Color(0x42f5f5fa),
        errorStyle: TextStyle(color: Color(0xffff5f5f), fontFamily: "Capriola", fontWeight: FontWeight.w700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: MaterialTheme.darkScheme().primary,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        errorMaxLines: 3,
      ),



      /// ELEVATED BTNS
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Capriola',
          ),
        ),
      ),

      /// OUTLINED BTNS
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Capriola',
          ),
        ),
      ),

      /// TEXT BTNS
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Capriola',
          ),
        ),
      ),

      /// ICON BTNS
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      /// FLOATING ACTION BTN
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      /// NAVIGATION BAR
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: MaterialTheme.darkScheme().surface,
        indicatorColor: MaterialTheme.darkScheme().primaryContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        height: 80,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Capriola',
              color: Colors.white,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontFamily: 'Capriola',
            color: Colors.white70,
          );
        }),
      ),

      /// DRAWER
      drawerTheme: DrawerThemeData(
        backgroundColor: MaterialTheme.darkScheme().surface,
        surfaceTintColor: Colors.transparent,
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),

      /// LIST TILES
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selectedTileColor: MaterialTheme.darkScheme().primaryContainer,
        selectedColor: MaterialTheme.darkScheme().onPrimaryContainer,
        textColor: Colors.white,
        iconColor: Colors.white70,
      ),

      /// RADIO BUTTONS
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.white70;
        }),
      ),

      /// SWITCHES
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return Colors.white70;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return MaterialTheme.darkScheme().surfaceContainerHighest;
        }),
      ),

      /// SLIDERS
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.white,
        inactiveTrackColor: MaterialTheme.darkScheme().surfaceContainerHighest,
        thumbColor: Colors.white,
        overlayColor: Colors.white.withValues(alpha: 0.1),
        trackHeight: 4,
      ),

      /// PROGRESS INDICATORS
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),

      /// TABS
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: Colors.white,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Capriola',
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'Capriola',
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      /// TOOLTIPS
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Capriola',
        ),
      ),

      /// SNACKBAR
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.white,
        contentTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Capriola',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      /// DIVIDER
      dividerTheme: const DividerThemeData(
        color: Colors.white24,
        thickness: 1,
        space: 1,
      ),
    );
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];

}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
