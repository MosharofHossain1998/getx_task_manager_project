import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data_network_caller/models/task_count_summary_list_model.dart';
import '../../data_network_caller/network_caller.dart';
import '../../data_network_caller/network_response.dart';
import '../../data_network_caller/utility/url.dart';

class NewTaskCountSummaryListController extends GetxController{

  bool _getTaskCountSummaryListInProgress = false;
  TaskCountSummaryListModel _taskCountSummaryList = TaskCountSummaryListModel();

  bool get TaskCountSummaryListInProgress => _getTaskCountSummaryListInProgress;
  TaskCountSummaryListModel get TaskCountSummaryList => _taskCountSummaryList;

  Future<bool> getNewTaskCountSummaryList() async {
    bool isSuccess = false;
    _getTaskCountSummaryListInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    _getTaskCountSummaryListInProgress = false;
    log(response.statusCode.toString());
    if (response.isSuccess) {
      _taskCountSummaryList =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
      isSuccess = true;
      update();
    }
    return isSuccess;
  }
}