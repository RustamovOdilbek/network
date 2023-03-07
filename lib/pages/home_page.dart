import 'package:flutter/material.dart';
import 'package:network_requests/model/post_model.dart';
import 'package:network_requests/service/http_service.dart';
import 'package:network_requests/service/log_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

   // _apiList();
    var post = Post(id: 1, title: "PDP", body: "Odilbek Rustamov", userId: "1");
   // _apiPostCreate(post);
    _apiPostDelete(post);
  }

  void _apiList(){
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      LogService.i(response.toString())
    });
  }

  void _apiPostCreate(Post post){
    Network.POST(Network.API_CREATE, Network.paramsCreate(post)).then((response) => {
      LogService.i(response.toString())
    });
  }

  void _apiPostUpdate(Post post){
    Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post)).then((response) => {
      LogService.i(response.toString())
    });
  }

  void _apiPostDelete(Post post){
    Network.DELETE(Network.API_DELETE + post.id.toString(), Network.paramsEmpty()).then((response) => {
      LogService.i(response.toString())
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo,
      ),
    );
  }
}
