import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/pages/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init hive
  await Hive.initFlutter();

// open box
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(color: Colors.deepPurple[400], elevation: 0)),
      home: const ToDoPage(),
    );
  }
}
