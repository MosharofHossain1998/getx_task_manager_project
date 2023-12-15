import 'package:get/get.dart';

import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class SignupController extends GetxController{

  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  Future<bool> signUp(String email, String firstName, String lastName, String phoneNumber, String password) async {
      _signUpInProgress = true;
      update();
      final NetworkResponse response =
      await NetworkCaller()
          .postRequest(Urls.registration , requestBody: {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": phoneNumber,
        "password": password,

      });
      _signUpInProgress = false;
      update();
      if (response.isSuccess) {
        return true;
      }
      return false;
  }
}