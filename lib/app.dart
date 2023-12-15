
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/add_new_task_controller.dart';
import 'package:module_12/ui/controllers/authentication_controller.dart';
import 'package:module_12/ui/controllers/canclled_task_list_controller.dart';
import 'package:module_12/ui/controllers/completed_task_controller.dart';
import 'package:module_12/ui/controllers/delete_task_status_controller.dart';
import 'package:module_12/ui/controllers/login_controller.dart';
import 'package:module_12/ui/controllers/main_bottom_nav_controller.dart';
import 'package:module_12/ui/controllers/new_task_controller.dart';
import 'package:module_12/ui/controllers/new_task_count_summary_list_controller.dart';
import 'package:module_12/ui/controllers/photo_picker_controller.dart';
import 'package:module_12/ui/controllers/pin_verification_controller.dart';
import 'package:module_12/ui/controllers/progress_task_list_controller.dart';
import 'package:module_12/ui/controllers/forgot_password_controller.dart';
import 'package:module_12/ui/controllers/reset_password_controller.dart';
import 'package:module_12/ui/controllers/signup_controller.dart';
import 'package:module_12/ui/controllers/update_profile_controller.dart';
import 'package:module_12/ui/controllers/update_task_status_controller.dart';
import 'package:module_12/ui/screen/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorFormKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorFormKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            )
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600
          ),
        ),
        primaryColor: Colors.green,
        primarySwatch:Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          )
        )
      ),
      initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthenticationController());
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(NewTaskCountSummaryListController());
    Get.put(AddNewTaskController());
    Get.put(UpdateTaskStatusController());
    Get.put(DeleteTaskStatusController());
    Get.put(SignupController());
    Get.put(UpdateProfileController());
    Get.put(PhotoPickerController());
    Get.put(CanclledTaskListController());
    Get.put(ProgressTaskListController());
    Get.put(ResetPasswordController());
    Get.put(PinVerificationController());
    Get.put(ForgotPasswordController());
    Get.put(CompleteTaskController());
    Get.put(MainBottomNavController());
  }

}
