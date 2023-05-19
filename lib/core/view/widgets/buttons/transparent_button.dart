import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.icon,
      this.width,
      this.height,
      this.borderRaduis})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final IconData? icon;
  final double? width;
  final double? height;
  final double? borderRaduis;

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Container(
      width: width ?? double.infinity,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: AppColors.backgroundcolor,
        borderRadius: BorderRadius.circular(borderRaduis ?? 8),
        border: Border.all(
          color: AppColors.primary,
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (icon != null)
            //   Icon(
            //     icon,
            //     color: color,
            //   ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            if (icon != null)
              Icon(
                icon,
                color: color,
              ),
          ],
        ),
      ),
    );
  }
}
