import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/l10n.dart';
import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../logic/preferences_cubit/preferences_cubit.dart';
import '../../services/alert.dart';
import '../../services/remote_config.dart';
import '../widgets/app_screen.dart';
import '../widgets/buttons/app_button.dart';
import 'walkthrough.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  static const id = '/choose-language-screen';

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  late SharedPreferences preferences;
  String selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    // FirebaseRemoteConfig.instance.checkForUpdates(context);
    selectedLanguage = context.read<PreferencesCubit>().state.language ?? 'en';
    loadSharedPreferences();
  }

  Future<void> loadSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var raduis=const Radius.circular(14);
    return AppScreen(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Card(
              color: AppColors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: raduis,topLeft: raduis,bottomRight: Radius.zero,bottomLeft: raduis,)
              ),
              child: ClipRRect(
                borderRadius:  BorderRadius.only(bottomRight: const Radius.circular(40),
                topLeft: raduis,topRight: raduis,bottomLeft: raduis),
                child: Container(
                  color: AppColors.white,
                  height: 150.h,
                    width: 200.w,
                  child: Container()
                ),
              ),
            ),
            const Spacer(flex: 2),
            Text(
              context.l10n.please_select_your_language,
              style: TextStyle(
                color: AppColors.eggplant,
                fontWeight: FontWeight.w500,
                height: 1.0,
                fontSize: 24.0.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              context.l10n.you_can_change_it_later,
              style: TextStyle(
                color: AppColors.blueGrey,
                fontWeight: FontWeight.w400,
                height: 1.0,
                fontSize: 14.0.sp,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 32.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: AppColors.veryLightBlue),
                color: AppColors.white,
              ),
              child: RadioListTile(
                value: 'en',
                groupValue: selectedLanguage,
                activeColor: AppColors.primary,
                // secondary: SvgPicture.asset(Assets.usa),
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (_) => setState(() => selectedLanguage = 'en'),
                title: Text(
                  'English',
                  style: TextStyle(
                    color: selectedLanguage == 'en'
                        ? AppColors.black
                        : AppColors.veryLightBlue,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: AppColors.veryLightBlue),
                color: AppColors.white,
              ),
              child: RadioListTile(
                value: 'ar',
                groupValue: selectedLanguage,
                activeColor: AppColors.primary,
                // secondary: SvgPicture.asset(Assets.egypt),
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (_) => setState(() => selectedLanguage = 'ar'),
                title: Text(
                  'العربية',
                  style: TextStyle(
                    color: selectedLanguage == 'ar'
                        ? AppColors.black
                        : AppColors.veryLightBlue,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const Spacer(),
            AppButton(
              textKey: context.l10n.continue_text,
              onPressed: () {
                if (context.read<PreferencesCubit>().state.language ==
                    selectedLanguage) {
                  Navigator.pushReplacementNamed(context, WalkthroughScreen.id);
                  preferences.setBool('walkthroughScreenShown', true);
                } else {
                  context
                      .read<PreferencesCubit>()
                      .setLanguage(selectedLanguage);
                }
                preferences.setBool('userChooseLanguage', true);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
