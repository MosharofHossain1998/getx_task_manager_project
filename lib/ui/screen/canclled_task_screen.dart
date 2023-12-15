import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/canclled_task_list_controller.dart';
import 'package:module_12/ui/screen/login_screen.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  CanclledTaskListController canclledTaskListController =
      Get.find<CanclledTaskListController>();

  Future<void> getCanclledTaskList() async {
    final response = await canclledTaskListController.getCanclledTaskList();
    if (!response) {
      Get.offAll(const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCanclledTaskList();
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
              child: GetBuilder<CanclledTaskListController>(
                  builder: (canclledTaskListController) {
                return Visibility(
                  visible: canclledTaskListController.canclledTaskInProgress ==
                      false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: getCanclledTaskList,
                    child: ListView.builder(
                        itemCount: canclledTaskListController
                                .taskListModel.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: canclledTaskListController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              getCanclledTaskList();
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
