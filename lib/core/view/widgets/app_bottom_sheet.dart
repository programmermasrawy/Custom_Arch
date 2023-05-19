import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import 'app_close_button.dart';

Future<void> showAppModalBottomSheet<T extends Cubit>({
  required BuildContext context,
  required String titleKey,
  String? messageKey,
  required List<Widget> widgetsList,
  double percentOfScreenHeight = 0.6,
  VoidCallback? onDismiss,
  T? bloc,
}) {
  FocusScope.of(context).unfocus();
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    builder: (_) {
      if (bloc == null) {
        return _BottomSheet(
          context: context,
          titleKey: titleKey,
          messageKey: messageKey,
          widgetsList: widgetsList,
          percentOfScreenHeight: percentOfScreenHeight,
          onDismiss: onDismiss,
        );
      }
      return BlocProvider<T>.value(
        value: bloc,
        child: _BottomSheet(
          context: context,
          titleKey: titleKey,
          messageKey: messageKey,
          widgetsList: widgetsList,
          percentOfScreenHeight: percentOfScreenHeight,
          onDismiss: onDismiss,
        ),
      );
    },
  );
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    Key? key,
    required this.context,
    this.titleKey = '',
    this.messageKey,
    required this.widgetsList,
    this.percentOfScreenHeight = 0.6,
    this.onDismiss,
  }) : super(key: key);

  final BuildContext context;
  final String titleKey;
  final String? messageKey;
  final List<Widget> widgetsList;
  final double percentOfScreenHeight;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  width: 125,
                  height: 5,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.5)),
                    color: AppColors.lightBlueGrey,
                  ),
                ),
              ),
              AppCloseButton(onPressed: () => dismiss(context: context)),
            ],
          ),
          Text(
            titleKey,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              height: 1.0,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (messageKey != null) const SizedBox(height: 20),
          if (messageKey != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                messageKey!,
                style: const TextStyle(
                    color: AppColors.blueyGrey,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                    fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
            ),
          if (messageKey != null) const SizedBox(height: 24),
          ConstrainedBox(
            constraints: BoxConstraints.loose(
              Size(double.infinity,
                  MediaQuery.of(context).size.height * percentOfScreenHeight),
            ),
            child: SingleChildScrollView(
              child: Column(children: widgetsList),
            ),
          ),
        ],
      ),
    );
  }

  void dismiss({required BuildContext context}) {
    onDismiss?.call();
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
