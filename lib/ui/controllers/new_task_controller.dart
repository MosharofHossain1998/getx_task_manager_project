
import 'package:get/get.dart';
import '../../data_network_caller/models/task_list_mode.dart';
import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class NewTaskController extends GetxController{

  bool _getNewTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get newTaskInProgress => _getNewTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getNewTaskList);
    _getNewTaskInProgress = false;
    ///log(response.statusCode.toString());
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
      update();
    }
    return isSuccess;
  }
}