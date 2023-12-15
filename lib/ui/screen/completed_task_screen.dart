import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/completed_task_controller.dart';
import 'package:module_12/ui/screen/login_screen.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  CompleteTaskController completeTaskController =
      Get.find<CompleteTaskController>();

  Future<void> getCompletedTaskList() async {
    final response = await completeTaskController.getCompletedTaskList();
    if (!response) {
      Get.offAll(const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCompletedTaskList();
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
              child: GetBuilder<CompleteTaskController>(
                  builder: (completeTaskController) {
                return Visibility(
                  visible:
                      completeTaskController.completedTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: getCompletedTaskList,
                    child: ListView.builder(
                        itemCount: completeTaskController
                                .taskModelList.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: completeTaskController
                                .taskModelList.taskList![index],
                            onStatusChange: () {
                              getCompletedTaskList();
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
