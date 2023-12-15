import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_12/ui/controllers/main_bottom_nav_controller.dart';
import 'package:module_12/ui/screen/canclled_task_screen.dart';
import 'package:module_12/ui/screen/completed_task_screen.dart';
import 'package:module_12/ui/screen/new_task_screen.dart';
import 'package:module_12/ui/screen/progress_task_screen.dart';

class MainButtomNavScreen extends StatefulWidget {
  const MainButtomNavScreen({super.key});

  @override
  State<MainButtomNavScreen> createState() => _MainButtomNavScreenState();
}

class _MainButtomNavScreenState extends State<MainButtomNavScreen> {

  MainBottomNavController mainBottomNavController = Get.find<MainBottomNavController>();

  final List<Widget> _screen = const[
    NewTasksScreen(),
    ProgressTasksScreen(),
    CompletedTasksScreen(),
    CancelledTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (mainBottomNavController) {
        return Scaffold(
          body: _screen[mainBottomNavController.currentSelectedScreen],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: mainBottomNavController.currentSelectedScreen,
            onTap: (index){
              mainBottomNavController.currentSelectedScreen = index;
            },
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.blue,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_outlined),label: 'New'),
              BottomNavigationBarItem(icon: Icon(Icons.rocket_launch_sharp),label: 'In Progress'),
              BottomNavigationBarItem(icon: Icon(Icons.done),label: 'Completed'),
              BottomNavigationBarItem(icon: Icon(Icons.close),label: 'Canclled'),
            ],
          ),
        );
      }
    );
  }
}
