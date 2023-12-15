import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'app.dart';

void main() {
  runApp(
      DevicePreview(builder: (context){
        return const TaskManagerApp();
      })
  );
}

