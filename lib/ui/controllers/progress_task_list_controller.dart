import 'package:get/get.dart';

import '../../data_network_caller/models/task_list_mode.dart';
import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class ProgressTaskListController extends GetxController{

  bool _getInProgressTask = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get progressTaskInProgress => _getInProgressTask;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getInProgressTaskList() async{
    _getInProgressTask = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getInProgressTaskList);
    _getInProgressTask =false;
    update();
    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      return true;
    }
    return false;
  }

}