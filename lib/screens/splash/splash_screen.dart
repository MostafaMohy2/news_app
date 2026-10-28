import 'package:flutter/material.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/build_context_extensions.dart';
import 'package:news_app/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 400), () {
      Navigator.pushReplacementNamed(context, HomeScreen.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.appConfig;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                provider.themeMode == ThemeMode.dark
                    ? AppAssets.logoLight
                    : AppAssets.logoDark,
              ),
            ),
            Image.asset(
              provider.themeMode == ThemeMode.dark
                  ? AppAssets.brandingLight
                  : AppAssets.brandingDark,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ],
        ),
      ),
    );
  }
}
