
import 'dart:convert';

import 'package:http/http.dart';

import '../model/employee_model.dart';

class Network {

  static String BASE = "dummy.restapiexample.com";

/*  Http Apis  */
  static String API_LIST = "/api/v1/employees";
  static String API_EMPLOYEE_ID = "/api/v1/employee/"; //{id}
  static String API_CREATE = "/api/v1/create";
  static String API_UPDATE = "/api/v1/update/"; //{id}
  static String API_DELETE = "/api/v1/delete/"; //{id}

  /*  Http Requests  */

  static Future<String?> GET(String api) async{
    var uri = Uri.http(BASE, api);
    var response = await get(uri);
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  static Future<String?> GET_EMP(String api) async{
    var uri = Uri.http(BASE, api);
    var response = await get(uri);
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api); // http or https
    var response = await put(uri, body: jsonEncode(params));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async{
    var uri = Uri.http(BASE, api, params);
    var response = await delete(uri, body: jsonEncode(params));
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

/* Http params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = Map();
    return params;
  }

  static Map<String, String> paramsCreate(Data employee){
    Map<String, String> params = Map();
    params.addAll({
      'name': employee.employeeName!,
      'salary': employee.employeeSalary!.toString(),
      'age': employee.employeeAge.toString()
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Data employee){
    Map<String, String> params = Map();
    params.addAll({
      'name': employee.employeeName!,
      'salary': employee.employeeSalary!.toString(),
      'age': employee.employeeAge.toString()
    });
    return params;
  }

}