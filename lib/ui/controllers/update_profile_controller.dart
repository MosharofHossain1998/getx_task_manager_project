import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data_network_caller/models/user_model.dart';
import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';
import 'authentication_controller.dart';

class UpdateProfileController extends GetxController{

  bool _profileUpdateInProgress = false;
  bool get profileUpdateInProgress => _profileUpdateInProgress;

  Future<bool> updateProfile(String email, String firstName, String lastName, String phoneNumber, String password, XFile? photo) async{
    _profileUpdateInProgress = true;
    update();

    String? photoBase64;
    Map<String , dynamic> inputData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": phoneNumber,
    };

    if(password.isNotEmpty){
      inputData["password"] = password;
    }

    if(photo != null){
      List<int> imageBytes = await photo!.readAsBytes();
      photoBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(Urls.postProfileUpdate,requestBody: inputData);

    _profileUpdateInProgress = false;
    update();

    if(response.isSuccess){

      Get.find<AuthenticationController>().updateUserInformation(
        UserModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: phoneNumber,
          photo: photoBase64 ?? Get.find<AuthenticationController>().user?.photo,
        ),
      );
      update();
      return true;
    }
    return false;

  }
}