import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/assets.dart';
import '../widgets/app_screen.dart';
import 'walkthrough.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  static const id = '/';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // static const shouldCallEndPoints = 1;
  int endPointsCalled = 0;
  // late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    // loadSharedPreferences();
    callAllEndpoints();
  }

  // Future<void> loadSharedPreferences() async {
  //   preferences = await SharedPreferences.getInstance();
  // }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      lightStatusBar: true,
      child: Stack(
        children: [
          SvgPicture.asset(
            Assets.brimoreLogoBG,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  void navigateToNextScreen() {
    // if (signedInUser) {
    //   Navigator.pushReplacementNamed(context, HomeScreen.id);
    // } else {
    Navigator.pushReplacementNamed(context, WalkthroughScreen.id);
    // preferences.setBool('walkthroughScreenShown', true);
    // }
  }

  void callAllEndpoints() {
    // FlutterBranchSdk.getLatestReferringParams().then((value) {
    //   print(value.isEmpty);
    //   navigateToNextScreen();
    // }).catchError((error) {
    //   print(error);
    // });

    // endPointsCalled = 0;
    // Future.delayed(const Duration(seconds: 4)).then((value) {
    //   endPointsCalled = 1;
    //   navigateToNextScreen();
    // });
    // context.read<ConstantsCubit>().constants();
    // context.read<CategoriesCubit>().reload();
    // context.read<HomeCubit>().home();

    Future.delayed(const Duration(seconds: 4)).then((value) {
      navigateToNextScreen();
    });
  }
}
