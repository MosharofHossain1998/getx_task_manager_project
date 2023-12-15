import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class ForgotPasswordController extends GetxController{

  bool _sentVerificationCodeOnEmailInProgress = false;
  bool get sentVerificationCodeOnEmailInProgress => _sentVerificationCodeOnEmailInProgress;

  Future<bool> getRecoveryEmailVerification(String email) async {
    _sentVerificationCodeOnEmailInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getRecoveryVerifyEmail(email));
    _sentVerificationCodeOnEmailInProgress = false;
    update();
    
    if(response.jsonResponse['status'] == 'success'){
      return true;
    }
    return false;
  }
}