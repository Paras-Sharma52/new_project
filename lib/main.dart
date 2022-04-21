import 'package:flutter/material.dart';
import 'package:new_project/provider/todoprovider.dart';
import 'package:new_project/todohome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: ((context) => Todoitem()),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Todohome(),
        ));
  }
}
