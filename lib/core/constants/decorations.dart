import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppDecorations {
  static InputDecoration inputTextDecoration({
    String? hint,
    String? label,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    bool? isDense,
  }) =>
      InputDecoration(
        prefixIconConstraints:
            const BoxConstraints(minHeight: 16, minWidth: 46),
        prefixIcon: prefixIcon,
        contentPadding: isDense == null
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 18)
            : const EdgeInsets.all(8),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1.5,
            color: focusedBorderColor ?? AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1.5,
            color: borderColor ?? AppColors.veryLightBlue,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              const BorderSide(width: 1.5, color: AppColors.veryLightBlue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.cherryRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.cherryRed),
        ),
        errorStyle: const TextStyle(
          color: AppColors.watermelon,
          fontWeight: FontWeight.w400,
          height: 1.0,
          fontSize: 14.0,
        ),
        hintText: hint,
        labelText: label,
        // hintStyle: AppTextStyles.appTextFieldHintStyle,
        fillColor: fillColor ?? AppColors.white,
        // focusColor: AppColors.brownishGrey,
        filled: true,
        alignLabelWithHint: true,
        isDense: isDense,
      );
}
