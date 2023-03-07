import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:network_requests/model/employee_model.dart';

import '../service/employees_service.dart';
import '../service/log_service.dart';

class EmployeePage extends StatefulWidget {
  static final String id = "employees_page";

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {

  @override
  void initState() {
    super.initState();

    var data = Data(id: 719, employeeName: "Odilbek", employeeSalary: 2000, employeeAge: 20);
    _apiEmployeeDelete(data);
  }

  void _apiList(){
    Network.GET(Network.API_LIST).then((response) => {
      LogService.i(response.toString())
    });
  }

  void _apiEmployess(var id){
    Network.GET(Network.API_EMPLOYEE_ID + id.toString()).then((response) => {
      LogService.i(response.toString())
    });
  }

  void _apiEmployessCreate(Data employee){
    Network.POST(Network.API_CREATE, Network.paramsCreate(employee)).then((response) => {
      LogService.i(response.toString())
    });
  }

  void _apiEmployeeUpdate(Data employee){
    Network.PUT(Network.API_UPDATE + employee.id.toString(), Network.paramsUpdate(employee)).then((response) => {
      LogService.i(response.toString())
    });
  }

  void _apiEmployeeDelete(Data employeet){
    Network.DELETE(Network.API_DELETE + employeet.id.toString(), Network.paramsEmpty()).then((response) => {
      LogService.i(response.toString())
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
