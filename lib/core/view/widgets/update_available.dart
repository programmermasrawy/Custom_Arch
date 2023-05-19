import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../l10n/l10n.dart';
import '../../constants/app_colors.dart';
import 'app_close_button.dart';
import 'buttons/app_button.dart';

class UpdateAvailable extends StatelessWidget {
  const UpdateAvailable({Key? key, this.mendatoy = true}) : super(key: key);

  final bool mendatoy;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 12.0,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!mendatoy)
                  AppCloseButton(onPressed: () => dismiss(context: context)),
                const SizedBox(height: 8),
                // Image.asset(
                //   Assets.rocket,
                //   width: 100.w,
                // ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.update_available,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      context.l10n.new_version,
                      style: const TextStyle(
                        color: AppColors.darkGreyBlue,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        fontSize: 14,
                      ),
                    )),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (!mendatoy)
                      Expanded(
                          child: AppButton(
                        key: const Key('update_available_button_dismiss'),
                        textKey: context.l10n.dismiss,
                        height: 35,
                        onPressed: () => dismiss(context: context),
                      )),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        key: const Key('update_available_button_update'),
                        textKey: context.l10n.update,
                        height: 35,
                        onPressed: update,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dismiss({required BuildContext context}) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> update() async {
    if (Platform.isAndroid) {
      await launchUrlString(
          'https://play.google.com/store/apps/details?id=com.app.brimore');
    } else if (Platform.isIOS) {
      await launchUrlString('https://apps.apple.com/app/com.app.brimore');
    }
  }
}
