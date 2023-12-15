
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/add_new_task_controller.dart';
import 'package:module_12/ui/widgets/body_background.dart';
import 'package:module_12/ui/widgets/profile_summary_card.dart';
import 'package:module_12/ui/widgets/snackbar_massage.dart';
import '../controllers/new_task_controller.dart';
import 'main_buttom_nav_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  AddNewTaskController addNewTaskController = Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const ProfileSummaryCard(),
              Expanded(
                child: BodyBackground(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 48,
                          ),
                          Text(
                            'ADD NEW TASK',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _subjectTEController,
                            decoration: const InputDecoration(
                              hintText: 'Subject',
                            ),
                            validator: (String? value) {
                              if (value!.trim().isEmpty ?? true) {
                                return 'Enter Your Subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _descriptionTEController,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                            ),
                            validator: (String? value) {
                              if (value!.trim().isEmpty ?? true) {
                                return 'Enter Description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<AddNewTaskController>(
                              builder: (addNewTaskController) {
                                return Visibility(
                                  visible: addNewTaskController.createTaskInProgress == false,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: createTask,
                                    child: const Icon(
                                        Icons.arrow_circle_right_outlined),
                                  ),
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if (_formKey.currentState!.validate()) {

      final response = await addNewTaskController.createTask(_subjectTEController.text.trim(), _descriptionTEController.text.trim());

      if (response) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        Get.find<NewTaskController>().getNewTaskList();
        if (mounted) {
          showSnackMassage(
            context,
            'Task Creation Successful',
          );
          ///Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainButtomNavScreen()), (route) => false);
          Get.offAll(const MainButtomNavScreen());
        }
      } else {
        if (mounted) {
          showSnackMassage(
              context, 'Task Creation Failed, Please Try Again', true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
