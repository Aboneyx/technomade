import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? height;
  final double? width;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? repeatController;
  final void Function(String)? onFieldSubmitted;
  final int? maxLength;
  // final double borderRadius;
  // final Color? fillColor;
  // final double borderWidth;
  final Color? fillColor;
  final bool? filled;
  final TextAlign textAlign;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final String? suffixText;
  final Function()? onEditingComplete;
  // final Color? borderColor;
  final BorderRadius? borderR;
  final Widget? label;
  final bool autofocus;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final String obscuringCharacter;
  final int? errorMaxLines;
  final TextStyle? errorStyle;
  final String? counterText;
  final Function()? onTap;
  final bool readOnly;
  final bool? enabled;
  final InputBorder? focusedBorder;
  final InputBorder? border;

  const CustomTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.height,
    this.width,
    this.keyboardType,
    this.maxLines = 1,
    this.inputFormatters,
    this.validator,
    this.repeatController,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.maxLength,
    // this.borderRadius = 100,
    // this.fillColor = Colors.white,
    // this.borderWidth = 0.6,
    this.onEditingComplete,
    this.suffixIconConstraints,
    this.textAlign = TextAlign.start,
    this.suffixText,
    this.textStyle,
    this.hintStyle,
    // this.borderColor,
    this.borderR,
    this.label,
    this.autofocus = false,
    this.focusNode,
    this.prefix,
    this.prefixIconConstraints,
    this.contentPadding,
    this.textInputAction,
    this.obscuringCharacter = '●',
    this.errorMaxLines,
    this.errorStyle,
    this.minLines,
    this.counterText,
    this.onTap,
    this.readOnly = false,
    this.enabled,
    this.fillColor,
    this.filled,
    this.focusedBorder,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap,
      textInputAction: textInputAction, // TextInputAction.done,
      autofocus: autofocus,
      onEditingComplete: onEditingComplete,
      autocorrect: false,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      obscuringCharacter: obscuringCharacter,
      // style: textStyle ?? AppTextStyles.m14w400.copyWith(color: Colors.white),
      inputFormatters: inputFormatters,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Colors.black,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      // cursorHeight: 18,
      validator: validator,
      textAlign: textAlign,
      maxLength: maxLength,
      // maxLengthEnforcement: ,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefix: prefix,
        prefixIconConstraints: prefixIconConstraints,
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        counterText: counterText,
        // suffixStyle: AppTextStyles.os12w400,
        suffixIconConstraints: suffixIconConstraints,
        label: label,
        hintStyle: hintStyle,
        filled: filled,
        fillColor: fillColor,
        contentPadding: contentPadding,
        hintText: hintText,
        errorMaxLines: errorMaxLines,
        errorStyle: errorStyle,
        focusedBorder: focusedBorder ?? border,
        border: border,
        enabledBorder: border,
      ),
    );
  }
}
