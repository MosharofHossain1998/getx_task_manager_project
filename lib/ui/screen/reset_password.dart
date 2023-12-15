import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/data_network_caller/network_caller.dart';
import 'package:module_12/data_network_caller/network_response.dart';
import 'package:module_12/data_network_caller/utility/url.dart';
import 'package:module_12/ui/screen/forgot_password_screen.dart';
import 'package:module_12/ui/screen/login_screen.dart';
import 'package:module_12/ui/screen/signup_screen.dart';
import 'package:module_12/ui/widgets/body_background.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.Email,
    required this.otp
  });
  final String Email,otp;


  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  ResetPasswordController resetPasswordController = Get.find<ResetPasswordController>();
  TextEditingController _resetPsswordTEController  = TextEditingController();

  Future<void> postResetPassword() async{
    final response = await resetPasswordController.postResetPassword(widget.Email, widget.otp, _resetPsswordTEController.text);

    if(response){
      if(mounted){
        Get.offAll(const LoginScreen());
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
                  'Set New Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Minimum password length should be more than 8 character',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _resetPsswordTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Enter Password'),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _resetPsswordTEController,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<ResetPasswordController>(
                    builder: (resetPasswordController) {
                      return Visibility(
                        visible: resetPasswordController.resetPasswordInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            postResetPassword();
                          },
                          child: const Text('Confirm'),
                        ),
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
                        Get.offAll(const LoginScreen());
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
