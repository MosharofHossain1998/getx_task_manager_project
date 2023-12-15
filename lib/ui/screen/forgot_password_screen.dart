
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/forgot_password_controller.dart';
import 'package:module_12/ui/screen/pin_verification_screen.dart';
import '../widgets/body_background.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController _emailTEController = TextEditingController();

  ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();

  Future<void> getRecoveryEmailVerification() async {

    final response = await forgotPasswordController.getRecoveryEmailVerification(_emailTEController.text);
    if(response){
      if(mounted){
        Get.to(PinVerificationScreen(Email: _emailTEController.text,));
        }
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'A 6 digit verification pin will send to your email address',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<ForgotPasswordController>(
                    builder: (forgotPasswordController) {
                      return Visibility(
                        visible: forgotPasswordController.sentVerificationCodeOnEmailInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              getRecoveryEmailVerification();
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                            )),
                      );
                    }
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have An Account?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Sign In',
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
    );
  }
}
