import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/authentication_controller.dart';
import 'package:module_12/ui/screen/update_profile_screen.dart';
import 'package:module_12/ui/screen/login_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({
    super.key, this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  String base64String = Get.find<AuthenticationController>().user?.photo ?? '';
  @override
  Widget build(BuildContext context) {

    if (base64String.startsWith('data:image')) {
      // Remove data URI prefix if present
      base64String =
          base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
    }

    Uint8List imageBytes = const Base64Decoder().convert(base64String);

    return GetBuilder<AuthenticationController>(
      builder: (authController) {
        return ListTile(
          onTap: () {
            if (widget.enableOnTap) {
              ///Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfile(),),);
              Get.to(const UpdateProfile());
            }
          },
          leading: CircleAvatar(
            child: authController.user?.photo == null
                ? const Icon(Icons.person)
                : ClipOval(
                  child: Image.memory(
                    imageBytes,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ),
          ),
          title: Text(
            fullName(authController),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            authController.user?.email ?? '',
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () async {
              AuthenticationController.clearAuthenticationData();
              if(mounted) {
                ///Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);
                Get.offAll(const LoginScreen());
              }
            },
            icon: const Icon(Icons.logout),
          ),
          tileColor: Colors.green,
        );
      }
    );
  }

  String fullName(AuthenticationController authenticationController){
    return '${authenticationController.user?.firstName ?? ''} ${authenticationController.user?.lastName ?? ''}';
  }
}
