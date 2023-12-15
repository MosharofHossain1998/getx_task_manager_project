import 'package:get/get.dart';

import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';
import 'new_task_controller.dart';

class AddNewTaskController extends GetxController{

  bool _createTaskInProgress = false;

  bool get createTaskInProgress => _createTaskInProgress;

  Future<bool> createTask(String subject, String description) async {
      bool isSuccess = false;

      _createTaskInProgress = true;
      update();
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.createNewTask, requestBody: {
        "title": subject,
        "description": description,
        "status": "New",
      });
      _createTaskInProgress = false;
      update();
      if (response.isSuccess) {
        isSuccess=true;
        update();
      }
      return isSuccess;
  }
}