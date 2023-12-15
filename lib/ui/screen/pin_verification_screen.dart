import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:module_12/data_network_caller/network_caller.dart';
import 'package:module_12/data_network_caller/network_response.dart';
import 'package:module_12/data_network_caller/utility/url.dart';
import 'package:module_12/ui/controllers/pin_verification_controller.dart';
import 'package:module_12/ui/screen/reset_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widgets/body_background.dart';
import 'login_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.Email});

   final String Email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}


class _PinVerificationScreenState extends State<PinVerificationScreen> {

  PinVerificationController pinVerificationController = Get.find<PinVerificationController>();
  TextEditingController _OTPTEController = TextEditingController();

  Future<void> getRecoverVerifyOTP() async{
    final response = await pinVerificationController.getRecoverVerifyOTP(widget.Email, _OTPTEController.text);
    if(response){
        Get.to(ResetPasswordScreen(Email: widget.Email, otp: _OTPTEController.text,));
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
                  'Pin Verification',
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
                PinCodeTextField(
                  controller: _OTPTEController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    activeColor: Colors.green,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<PinVerificationController>(
                    builder: (pinVerificationController) {
                      return Visibility(
                        visible: pinVerificationController.pinVerificationInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            getRecoverVerifyOTP();
                          },
                          child: const Text('Verify'),
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
