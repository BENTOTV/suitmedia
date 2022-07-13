import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas/name/name.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _namaController = TextEditingController();
  final _palindromeController = TextEditingController();
  String hasil = "";

 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Appliaski Suitmedia"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 8,
            //margin: EdgeInsets.only(right: 30,left: 30,top: 20,bottom: 40),
            child: Padding(
              padding: EdgeInsets.only(right: 50,left: 50,top: 70,bottom: 70),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("SuitMedia",style: TextStyle(fontSize: 20),),
                  TextFormField(
                    controller: _namaController,
                    keyboardType: TextInputType.text,
                    style:const  TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: "Nama",
                      hintStyle: TextStyle(fontSize: 14)
                    ),
                  ),
                  TextFormField(
                    controller: _palindromeController,
                    keyboardType: TextInputType.text,
                    style:const  TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: "Text",
                      hintStyle: TextStyle(fontSize: 14)
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                        onPressed: (){
                          setState(() {
                            hasil= Palindrome(_palindromeController.text);
                          });
                        
                          
                        }, 
                        child: const Text("Check",style: TextStyle(
                          fontSize: 14,color: Colors.white
                        ),)),
                         TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                        onPressed: (){
                          Get.to(Name(nama: _namaController.text,akhir: "",awal: "",));
                        }, 
                        child: const Text("Next",style: TextStyle(
                          fontSize: 14,color: Colors.white
                        ),)),
                        
                    ],
                  ),
                  
                 Text( hasil.toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String Palindrome(String arry){
  var a= arry;
    {{var jml = a.length;
    var b = "";
    var status = "";
      for (int i=(jml-1); i >= 0; i--) { 
        b += a[i];
        }
    if (a==b) {
        status = "Kata $a adalah Palindrom";
        }else{
          status ="Kata $a bukan palindrom";
        }
      return status;
        }}
}
