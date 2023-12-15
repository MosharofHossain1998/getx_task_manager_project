import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/progress_task_list_controller.dart';
import 'package:module_12/ui/screen/login_screen.dart';
import 'package:module_12/ui/widgets/profile_summary_card.dart';

import '../widgets/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  ProgressTaskListController progressTaskListController =
      Get.find<ProgressTaskListController>();

  Future<void> getInProgressTaskList() async {
    final response = await progressTaskListController.getInProgressTaskList();
    if (!response) {
      Get.offAll(const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInProgressTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<ProgressTaskListController>(
                  builder: (progressTaskController) {
                return Visibility(
                  visible:
                      progressTaskController.progressTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: getInProgressTaskList,
                    child: ListView.builder(
                        itemCount: progressTaskController
                                .taskListModel.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: progressTaskController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              getInProgressTaskList();
                            },
                          );
                        }),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
