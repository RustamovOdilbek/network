import 'package:flutter/material.dart';
import 'package:network_requests/pages/detail_page.dart';
import 'package:network_requests/pages/employees_page.dart';
import 'package:network_requests/pages/home_page.dart';
import 'package:network_requests/pages/network_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: EmployeePage(),
    );
  }
}
