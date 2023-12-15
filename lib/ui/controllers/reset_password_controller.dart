import 'package:get/get.dart';
import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class ResetPasswordController extends GetxController{

  bool _resetPasswordInProgress = false;
  bool get resetPasswordInProgress => _resetPasswordInProgress;

  Future<bool> postResetPassword(String email, String otp, String resetPassword) async{
    _resetPasswordInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.postRecoverResetPass,requestBody: {
      "email": email,
      "OTP": otp,
      "password": resetPassword
    });
    _resetPasswordInProgress = false;
    update();
    if(response.jsonResponse['status'] == 'success'){
      return true;
    }
    return false;
  }
}