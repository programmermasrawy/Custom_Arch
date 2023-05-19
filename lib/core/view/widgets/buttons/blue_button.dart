import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key? key,
    required this.textKey,
    required this.onPressed,
    this.height,
    this.width,
    this.margin,
    this.child,
    this.color,
    this.isLoading = false,
  }) : super(key: key);

  final String textKey;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Container(
      width: width ?? double.infinity,
      margin: margin ?? EdgeInsets.zero,
      height: height ?? 56,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.primary,
      ),
      child: MaterialButton(
        // color: color ?? (mainButton ? BlueColors.primary : BlueColors.white),
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
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
      ),
    );
  }
}
