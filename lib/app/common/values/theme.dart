import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AppTheme {
  // const AppTheme._();

  static ThemeData get theme {
    // final inputBorder = 16.outlineInputBorder(
    //   borderSide: 3.borderSide(),
    // );

    final hintStyle = AppTextStyle.semiBoldStyle.copyWith(
      color: AppColors.doveGray,
      fontSize: Dimens.fontSize14,
    );

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.activButtonColor(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme:  AppBarTheme(
        color: AppColors.activButtonColor(),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.activButtonColor(),
        height: 45,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(.14);
              }

              return null;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (_) => AppTextStyle.buttonTextStyle,
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.doveGray;
              }
              return null;
            },
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(.14);
              }

              return null;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (_) => AppTextStyle.buttonTextStyle,
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      floatingActionButtonTheme:  FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: AppColors.activButtonColor(),
      ),
      textTheme: TextTheme(
        subtitle1: AppTextStyle.regularStyle.copyWith(
          color: AppColors.mineShaft,
          fontSize: Dimens.fontSize14,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 3,
        ),
        prefixStyle: AppTextStyle.regularStyle.copyWith(
          fontSize: Dimens.fontSize14,
          color: AppColors.black,
        ),
        hintStyle: hintStyle,
        labelStyle: hintStyle,
        enabledBorder:     OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:const BorderSide(width: 3),
      ),
        disabledBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:const BorderSide(width: 3),
      ),
        focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:const BorderSide(width: 3),
      ),
        border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:const BorderSide(width: 3),
      ),
      ),
      cardTheme: CardTheme(
        color: Colors.white.withOpacity(0.85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      bottomSheetTheme:const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
          ),
        ),
      ),
    );
  }
}
