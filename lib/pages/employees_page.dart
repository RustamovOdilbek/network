import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:network_requests/model/employee_model.dart';

import '../service/employees_service.dart';
import '../service/log_service.dart';
import 'detail_page.dart';

class EmployeePage extends StatefulWidget {
  static final String id = "employees_page";

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  var isLoading = false;
  var items = [];

  @override
  void initState() {
    super.initState();

    _apiPostList();
  }


  void _apiPostList() async{
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST);
    LogService.i("message");
    if (response != null) {
      setState(() {
        isLoading = false;
        items = Network.parseEmployeeList(response).data!;
      });
    }
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

  void _apiEmployeeDelete(String id){
    Network.DELETE(Network.API_DELETE, Network.paramsEmpty()).then((response) => {
      LogService.i(response.toString())
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee"),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  child: itemHomePost(items[index]),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(task: items[index]),
                      ),
                    );
                  },
                );;
              },
            ),

            isLoading ? Center(
              child: CircularProgressIndicator(),
            ) : SizedBox.shrink()
          ],
        )
    );
  }

  Widget itemHomePost(Data data){
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){
              //delete api
            //  _apiEmployeeDelete(data.id.toString());
            },
            flex: 3,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
          )
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.employeeName! + data.id.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

            SizedBox(height: 5,),

            Text( "${data.employeeSalary!}\$"),
          ],
        ),
      ),
    );
  }
}
