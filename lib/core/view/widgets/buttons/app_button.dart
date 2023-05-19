import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      required this.textKey,
      required this.onPressed,
      this.height,
      this.width,
      this.margin,
      this.child,
      this.color,
      this.isLoading = false,
      this.fontSize,
      this.startColor = AppColors.primary,
      this.endColor = AppColors.cherryRed})
      : super(key: key);

  final String textKey;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final bool isLoading;
  final double? fontSize;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Container(
      width: width ?? double.infinity,
      margin: margin ?? EdgeInsets.zero,
      height: height ?? 56,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: const Alignment(0.9, 0.5),
          end: const Alignment(0, 0.5),
          colors: [
            startColor,
            endColor,
          ],
        ),
      ),
      child: MaterialButton(
        // color: color ?? (mainButton ? AppColors.primary : AppColors.white),
        onPressed: onPressed,
        disabledColor: AppColors.brownishGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: AppColors.white,
              )
            : child ??
                Text(
                  textKey,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize ?? 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
      ),
    );
  }
}
