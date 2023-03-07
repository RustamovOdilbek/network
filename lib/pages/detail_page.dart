import 'package:flutter/material.dart';
import 'package:network_requests/service/log_service.dart';

import '../model/employee_model.dart';

class DetailPage extends StatefulWidget {
  static final String id = "detail_page";

  final Data task;
  DetailPage({Key? key, required this.task}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.task.employeeSalary.toString()),
      ),
    );
  }
}
