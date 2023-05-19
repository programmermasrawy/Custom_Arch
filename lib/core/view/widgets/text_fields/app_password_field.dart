import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/decorations.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    Key? key,
    this.hintKey,
    this.focusNode,
    this.labelKey,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.prefixIcon,
    this.margin,
  }) : super(key: key);

  final String? hintKey;
  final FocusNode? focusNode;
  final String? labelKey;
  final FormFieldValidator<String>? validator;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final EdgeInsets? margin;

  @override
  _AppPasswordFieldState createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.labelKey ?? '',
          style: const TextStyle(
            color: AppColors.browngrey,
            fontWeight: FontWeight.w700,
            fontSize: 14.0,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 10),
          child: Theme(
            data: Theme.of(context).copyWith(
              primaryColor: AppColors.brownishGrey,
            ),
            child: TextFormField(
              focusNode: widget.focusNode,
              validator: widget.validator,
              onChanged: widget.onChanged,
              obscureText: !_passwordVisible,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(
                color: AppColors.blacktext,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              decoration: AppDecorations.inputTextDecoration(
                hint: widget.hintKey,
                prefixIcon: widget.prefixIcon,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(
                    () => _passwordVisible = !_passwordVisible,
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: widget.textInputAction ?? TextInputAction.done,
              onFieldSubmitted: widget.onFieldSubmitted,
            ),
          ),
        ),
      ],
    );
  }
}
