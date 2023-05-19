import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class AppFlatButton extends StatelessWidget {
  const AppFlatButton({
    Key? key,
    required this.onPressed,
    required this.textKey,
    this.underLined = true,
    this.style,
    this.padding,
    this.textAlign,
  }) : super(key: key);

  final String textKey;
  final VoidCallback? onPressed;
  final bool underLined;
  final TextStyle? style;
  final EdgeInsets? padding;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        textKey,
        textAlign: textAlign ?? TextAlign.center,
        style: style ??
            TextStyle(
              decoration:
                  underLined ? TextDecoration.underline : TextDecoration.none,
              color: onPressed == null
                  ? AppColors.brownishGrey
                  : AppColors.primary,
              height: 1.0,
              fontSize: 14,
              fontWeight: onPressed == null ? FontWeight.w500 : FontWeight.w500,
            ),
      ),
    );
  }
}
