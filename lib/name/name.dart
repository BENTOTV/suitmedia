import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas/model/user.dart';
import 'package:tugas/user/body.dart';

class Name extends StatefulWidget {
   Name({ Key? key , this.nama,required this.awal,required this.akhir}) : super(key: key);
  String? nama;
  String awal;
  String akhir;
  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  String ganti = "";
  @override
  void initState() {
        if(widget.awal.isEmpty && widget.akhir.isEmpty){
          setState(() {
            ganti = "Choose User";
          });
        }else{
          setState(() {
        ganti = widget.awal.toString()+widget.akhir.toString();
      }); 
        }

      
           
    
    
    super.initState();
  }
  @override  
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen"),),
      body: SingleChildScrollView(
        child: Column(             
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[          
            Container(            
              height: 40,
              width: 100,
              child: Column(               
                crossAxisAlignment: CrossAxisAlignment.start,             
                children: <Widget>[
                  const Text("Welcome",style: TextStyle(
                    fontSize: 14
                  ),),
                  Text(widget.nama.toString(),style:const  TextStyle(
                    fontSize: 14
                  ),)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 300,left: 120),
              height: 500,                       
              width: double.infinity,
              child: 
               Text(ganti, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            Center(
              child: TextButton(
                onPressed: (){
                  // setState(() {
                  //   ganti = widget.awal.toString()+widget.akhir.toString();
                  // });
                  Get.to( Body(nama: widget.nama.toString(),));
                },
                style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
          ),
                child: Text("Choose a User", style: TextStyle(fontSize: 14,color: Colors.white),)),
            )
          ],
        ),
      ),
      
    );
  }
}