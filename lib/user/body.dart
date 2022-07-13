import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:tugas/name/name.dart';
class Body extends StatefulWidget {
  const Body({ Key? key ,required this.nama}) : super(key: key);
  final String nama ;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {  
  late List<Datum> dataList = [];
  late Future<List<Datum>> _future;
  int pages = 1;  
  final ScrollController _scrollController = ScrollController();
  bool loading = false;

  Future<List<Datum>> fetchDataUSer({required int page}) async {
    var endpoint = Uri.parse("https://reqres.in/api/users?page=$page");
  var respone = await http.get(endpoint);
  if(respone.statusCode ==200){
    final parsed = json.decode(respone.body);
    User listdata = User.fromJson(parsed);
    dataList.addAll(listdata.data);
    pages++;
  return dataList;
  }
  else {
      throw Exception('Failed to load data');
    }
  }

  Future _refreshPage() async{
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      dataList.clear();
      pages = 2;
    });
    _future = fetchDataUSer(page: pages);
  }

  @override
  initState(){
    _future = fetchDataUSer(page: pages);
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&!loading) {
        setState(() {
          loading = true;
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _future = fetchDataUSer(page: pages);
        });
        setState(() {
          loading = false;
        });
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Third Screen"),),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot<List<Datum>> snapshot){
            if(snapshot.hasData){
              var listDataUser = snapshot.data;
              if(listDataUser!.isNotEmpty){
                return Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                     return Stack(
                      children: <Widget>[
                        RefreshIndicator(
                          onRefresh: _refreshPage,
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listDataUser.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                leading: Image.network(listDataUser[index].avatar.toString()),
                                title: Text(listDataUser[index].firstName.toString()+listDataUser[index].lastName.toString()),
                                
                                subtitle: Text(listDataUser[index].email.toString()),
                                onTap: (){
                                  Get.to(Name(awal:listDataUser[index].firstName.toString() ,akhir: listDataUser[index].lastName.toString(),nama: widget.nama,));
                                }
                              );
                            }
                            ),
                  
                          ),
                          if(loading)...[
                                   const Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: SizedBox(
                                        height: 80,
                                        width: 20,
                                        child:  Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ]
                      ],
                    );
                    },                    
                  ),
                );
                }else {
                    return Center(
                      child: Column(
                        children: const <Widget>[
                          Text("Tidak Ada Data")
                        ],
                      ),
                    );
                  }
              }else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: const <Widget>[
                              SizedBox(height: 5),
                              CircularProgressIndicator(),
                              SizedBox(height: 5),
                            ],
                          ),
                        );
                      }
                    ),
                  );
                }
               }            
            )
        ],
      ),
    );    
  }         
    
  }
 
