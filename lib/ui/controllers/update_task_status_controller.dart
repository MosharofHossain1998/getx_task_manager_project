import 'package:get/get.dart';

import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class UpdateTaskStatusController extends GetxController{
  Future<bool> updateTaskStatus(String status, String taskId) async {
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.getUpdateTaskStatus(taskId, status),
    );
    if(response.isSuccess){
      return true;
    }
    return false;
  }
}