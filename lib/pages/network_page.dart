import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:network_requests/model/post_model.dart';
import 'package:network_requests/service/http_service.dart';
import 'package:network_requests/service/log_service.dart';


class NetworkPage extends StatefulWidget {
  static final String id = "network_page";

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  var isLoading = false;
  var items = [];

  @override
  void initState() {
    super.initState();

    _apiPostList();

  }

  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      setState(() {
        isLoading = false;
        items = Network.parsePostList(response);
      });
    }else{
      LogService.i("message");
    }
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

  void _apiPostDelete(String id){
    Network.DELETE(Network.API_DELETE + id, Network.paramsEmpty()).then((response) => {
      _apiPostList()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemHomePost(items[index]);
            },
          ),

          isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : SizedBox.shrink()
        ],
      )
    );
  }
  
  Widget itemHomePost(Post post){
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){
              //delete api
              _apiPostDelete(post.id.toString());
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
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title!.toUpperCase(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

            SizedBox(height: 5,),

            Text(post.body!),
          ],
        ),
      ),
    );
  }
}
