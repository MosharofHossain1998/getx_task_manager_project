import 'package:get/get.dart';

import '../../data_network_caller/models/task_list_mode.dart';
import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class CompleteTaskController extends GetxController{

  bool _getCompletedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get completedTaskInProgress => _getCompletedTaskInProgress;
  TaskListModel get taskModelList => _taskListModel;

  Future<bool> getCompletedTaskList() async{

    _getCompletedTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getCompletedTaskList);
    _getCompletedTaskInProgress = false;
    update();
    if(response.isSuccess){
      var _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      return true;
    }
    return false;

  }
}