part of 'resources.dart';

mixin AppTheme {
  static ThemeData get light => ThemeData(
        // fontFamily: FontFamily.nunito,
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black),
          displayMedium: TextStyle(color: Colors.black),
          displaySmall: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
          labelLarge: TextStyle(color: Colors.black),
          labelMedium: TextStyle(color: Colors.black),
          labelSmall: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          headlineLarge: TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: Colors.black),
          headlineSmall: TextStyle(color: Colors.black),
        ),
        // textTheme: GoogleFonts.latoTextTheme(bodyColor: Colors.white, displayColor: Colors.white),
        scaffoldBackgroundColor: AppColors.static,
        brightness: Brightness.light,
        // primaryColor: AppColors.static,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          // systemOverlayStyle: SystemUiOverlayStyle.dark,
          // backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black),
          centerTitle: true,
        ),
        useMaterial3: true,
        colorSchemeSeed: AppColors.mainColor,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.static,
          modalBarrierColor: Color.fromRGBO(0, 0, 0, 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.static,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: AppColors.labelColorLightSecondary,
          ),
          errorStyle: const TextStyle(
            fontSize: 13,
            color: AppColors.red,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(4),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(4),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            // borderSide: BorderSide(
            //   color: Colors.white.withOpacity(0.5),
            // ),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          // unselectedLabelColor: AppColors.day500,
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
          ),
        ),
        dialogTheme: const DialogTheme(),
        // dialogBackgroundColor: AppLightColors.base50,
        navigationBarTheme: const NavigationBarThemeData(
          height: 70,
          // elevation: 0.1,
          // elevation:
        ),
      );
}
