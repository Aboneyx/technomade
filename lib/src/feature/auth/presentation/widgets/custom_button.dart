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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: bgColor ?? AppColors.mainColor, border: border),
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
