import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';

class CustomButton extends StatelessWidget {
  final Color? bgColor;
  final Border? border;
  final double? height;
  final TextStyle? textStyle;
  final Function()? onTap;
  final String text;
  final EdgeInsetsGeometry? padding;
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    this.bgColor,
    this.border,
    this.height,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor ?? AppColors.mainColor,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              text,
              style: textStyle ?? const TextStyle(fontSize: 17, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final Widget? child;
  final void Function()? onPressed;
  final ButtonStyle style;
  final double? width;
  final double? height;
  final String text;
  final bool isExpanded;
  final void Function()? onLongPress;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.style,
    required this.child,
    this.width,
    this.height,
    this.text = '',
    this.isExpanded = true,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (isExpanded ? double.infinity : null),
      height: height ?? 44,
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: child ??
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}

class CustomElevatedButtonStyles {
  CustomElevatedButtonStyles._();

  static ButtonStyle primaryButtonStyle(
    BuildContext context, {
    double elevation = 0,
    double radius = 8,
    double height = 44,
    Color? backgroundColor,
    Color? foregroundColor = Colors.white,
    Color? disabledForegroundColor = Colors.white,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    EdgeInsetsGeometry? padding,
    BorderSide side = BorderSide.none,
  }) {
    return ElevatedButton.styleFrom(
      // padding: EdgeInsets.all(value),
      // alignment: Alignment.center,
      fixedSize: Size.fromHeight(height),
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor ?? AppColors.mainColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor ?? AppColors.mainColor.withOpacity(0.4),
      elevation: elevation,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: side,
      ),
      padding: padding,
    );
  }
}
