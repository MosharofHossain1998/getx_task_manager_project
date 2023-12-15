import 'package:get/get.dart';

import '../../data_network_caller/models/task_list_mode.dart';
import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class CanclledTaskListController extends GetxController{

  bool _getCanclledTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get canclledTaskInProgress => _getCanclledTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCanclledTaskList() async{
    _getCanclledTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getCanclledTaskList);
    _getCanclledTaskInProgress = false;
    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      update();
      return true;
    }
    return false;
  }
}