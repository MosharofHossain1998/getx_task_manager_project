import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/delete_task_status_controller.dart';
import '../../data_network_caller/models/task.dart';
import '../controllers/update_task_status_controller.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onStatusChange,
  });

  final Task task;
  final VoidCallback onStatusChange;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {

  UpdateTaskStatusController updateTaskStatusController = Get.find<UpdateTaskStatusController>();
  DeleteTaskStatusController deleteTaskStatusController = Get.find<DeleteTaskStatusController>();

  Future<void> updateTaskStatus(String status) async {
    final  response = await updateTaskStatusController.updateTaskStatus(status, widget.task.sId ?? '');
    if(response){
      widget.onStatusChange();
    }
  }

  Future<void> deleteTaskStatus() async{
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Delete Task'),
        actions: [
          TextButton(onPressed: () async{
            Get.back();
            final response = await deleteTaskStatusController.deleteTaskStatus(widget.task.sId ?? '');

            if(response){
              widget.onStatusChange();
            }
          }, child: const Text('Delete')),
          TextButton(onPressed: (){
            Get.back();
          }, child: const Text('Cancel')),
        ],
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task.title ?? ''),
            Text(widget.task.description ?? ''),
            Text(
              'Date : ${widget.task.createdDate}',
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showUpdateStatusModal();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteTaskStatus();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> item = TaskStatus.values
        .map(
          (e) => ListTile(
            title: Text(e.name),
            onTap: () {
              updateTaskStatus(e.name);
              ///Navigator.pop(context);
              Get.back();
            },
          ),
        )
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: item,
          ),
          actions: [
            TextButton(
              onPressed: () {
                ///Navigator.pop(context);
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
