import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../l10n/l10n.dart';
import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../services/remote_config.dart';
import '../widgets/app_screen.dart';
import '../widgets/buttons/app_button.dart';
import '../widgets/buttons/app_flat_button.dart';
import 'choose_language.dart';
import 'service_not_available_screen.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({Key? key}) : super(key: key);

  static const id = '/walkthrough-screen';
  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final _controller = PageController();

  int _currentPage = 0;
  String _buttonTitle = '';
  // Timer? timer;

  @override
  void initState() {
    super.initState();
    FirebaseRemoteConfig.instance.checkForUpdates(context);
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page?.toInt() ?? 0;
        _buttonTitle =
            _currentPage == 2 ? context.l10n.buy_now : context.l10n.next;
      });

    });
    // timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
    //   if (_currentPage < 2) {
    //     _currentPage++;
    //   } else {
    //     timer.cancel();
    //   }

    //   _controller.animateToPage(
    //     _currentPage,
    //     duration: const Duration(milliseconds: 350),
    //     curve: Curves.easeIn,
    //   );
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // if (timer?.isActive ?? false) {
    //   timer?.cancel();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: AppColors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
          systemStatusBarContrastEnforced: true,
          systemNavigationBarColor: Colors.transparent,
          // systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        actions: [
          _currentPage != 2
              ? AppFlatButton(
                  onPressed: () {

                  },
                  textKey: 'points',
                )
              : Container(),
          _currentPage != 2
              ? AppFlatButton(
            onPressed: () {

            },
            textKey: 'home',
          )
              : Container(),
        ],
        elevation: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                children: [
                  WalkThrough(
                    titleKey: context.l10n.start_ur_business,
                    messageKey: context.l10n.start_ur_business_meg,
                    walkLottie: Assets.walkthrough02,
                  ),
                  WalkThrough(
                    titleKey: context.l10n.instance_win,
                    messageKey: context.l10n.instance_win_msg,
                    walkLottie: Assets.walkthrough01,
                  ),
                  WalkThrough(
                    titleKey: context.l10n.order_track,
                    messageKey: context.l10n.order_track_msg,
                    walkLottie: Assets.walkthrough03,
                  ),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.primary,
                dotColor: AppColors.primary.withOpacity(0.3),
                dotHeight: 6,
                dotWidth: 10,
                expansionFactor: 2,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: AppButton(
                    key: const Key('next'),
                    textKey:
                        _buttonTitle.isEmpty ? context.l10n.next : _buttonTitle,
                    onPressed: () {
                      if (_currentPage < 2) {
                        _currentPage++;
                        _controller.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                        );
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          ChooseLanguageScreen.id,
                        );
                      }
                      /*  =>
                          Navigator.pushNamed(context, RegisterScreen.id)*/
                    },
                  ),
                ),
              ],
            ),
            const SafeArea(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}

class WalkThrough extends StatelessWidget {
  const WalkThrough({
    Key? key,
    required this.titleKey,
    required this.messageKey,
    required this.walkLottie,
  }) : super(key: key);

  final String titleKey;
  final String messageKey;
  final String walkLottie;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Lottie.asset(walkLottie),
          ),
        ),
        Expanded(child: Container()),
        Text(
          titleKey,
          textAlign: TextAlign.center,
          style: const TextStyle(
            height: 1.0,
            fontSize: 24,
            color: AppColors.rhino,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          messageKey,
          textAlign: TextAlign.center,
          style: const TextStyle(
            height: 1.0,
            fontSize: 15,
            color: AppColors.rhino,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
