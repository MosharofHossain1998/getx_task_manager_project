import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/login_controller.dart';
import 'package:module_12/ui/screen/forgot_password_screen.dart';
import 'package:module_12/ui/screen/main_buttom_nav_screen.dart';
import 'package:module_12/ui/screen/signup_screen.dart';
import 'package:module_12/ui/widgets/body_background.dart';
import 'package:module_12/ui/widgets/snackbar_massage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value!.trim().isEmpty ?? true) {
                          return 'Enter Your Emil';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty ?? true) {
                        return 'Enter your password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child:
                        GetBuilder<LoginController>(builder: (loginController) {
                      return Visibility(
                        visible: loginController.loginInprogress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: login,
                          child: const Icon(
                            Icons.arrow_circle_right_outlined,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.to(const ForgotPasswordScreen());
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have An Account?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(const SignUpScreen());
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final response = await _loginController.login(
        _emailTEController.text.trim(), _passwordTEController.text);
    if (response) {
        Get.offAll(const MainButtomNavScreen());
    } else {
      if (mounted) {
        showSnackMassage(context, _loginController.failerMassage);
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
