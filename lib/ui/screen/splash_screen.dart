
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:module_12/ui/controllers/authentication_controller.dart';
import 'package:module_12/ui/controllers/reset_password_controller.dart';
import 'package:module_12/ui/screen/login_screen.dart';
import 'package:module_12/ui/screen/main_buttom_nav_screen.dart';
import 'package:module_12/ui/widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      goToLoginSignup();
    });
  }

  void goToLoginSignup() async {
    final bool isLoggedIn = await Get.find<AuthenticationController>().checkAuthenticationState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAll(
        isLoggedIn ? const MainButtomNavScreen() : const LoginScreen(),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 120,
          ),
        ),
      ),
    );
  }
}
