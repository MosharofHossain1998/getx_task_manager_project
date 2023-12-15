import 'package:get/get.dart';

import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class DeleteTaskStatusController extends GetxController{
  Future<bool> deleteTaskStatus(String taskId) async{

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getDeleteTaskStatus(taskId));

    if(response.isSuccess){
      return true;
    }
    return false;
  }

}