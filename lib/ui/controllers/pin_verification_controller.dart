import 'package:get/get.dart';
import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class PinVerificationController extends GetxController{

  bool _pinVerificationInProgress = false;
  bool get pinVerificationInProgress => _pinVerificationInProgress;

  Future<bool> getRecoverVerifyOTP(String email, String OTP) async{
    _pinVerificationInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getRecoveryVerifyOTP(email,OTP));
    _pinVerificationInProgress = false;
    update();
    if(response.jsonResponse['status'] == 'success'){
      return true;
    }
    return false;
  }
}