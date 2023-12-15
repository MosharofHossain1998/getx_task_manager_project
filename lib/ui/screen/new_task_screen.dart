import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/new_task_controller.dart';
import 'package:module_12/ui/controllers/new_task_count_summary_list_controller.dart';
import 'package:module_12/ui/screen/add_new_task_screen.dart';
import '../../data_network_caller/models/task_count.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_item_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<NewTaskCountSummaryListController>()
          .getNewTaskCountSummaryList();

      /// Dependency Injection
      Get.find<NewTaskController>().getNewTaskList();

      /// Dependency Injection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));

          if (response != null && response == true) {
            Get.find<NewTaskController>().getNewTaskList();
            Get.find<NewTaskCountSummaryListController>()
                .getNewTaskCountSummaryList();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            GetBuilder<NewTaskCountSummaryListController>(
                builder: (newTaskCountSummaryListController) {
              return Visibility(
                visible: newTaskCountSummaryListController
                            .TaskCountSummaryListInProgress ==
                        false &&
                    (newTaskCountSummaryListController
                            .TaskCountSummaryList.taskCountList?.isNotEmpty ??
                        false),
                replacement: const LinearProgressIndicator(),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: newTaskCountSummaryListController
                            .TaskCountSummaryList.taskCountList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      TaskCount taskCount = newTaskCountSummaryListController
                          .TaskCountSummaryList.taskCountList![index];
                      return FittedBox(
                        child: SummaryCard(
                          count: taskCount.sum.toString(),
                          title: taskCount.sId ?? '',
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            Expanded(
              child:
                  GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Visibility(
                  visible: newTaskController.newTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () => newTaskController.getNewTaskList(),
                    child: ListView.builder(
                        itemCount:
                            newTaskController.taskListModel.taskList?.length ??
                                0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: newTaskController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              newTaskController.getNewTaskList();
                              Get.find<NewTaskCountSummaryListController>()
                                  .getNewTaskCountSummaryList();
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
