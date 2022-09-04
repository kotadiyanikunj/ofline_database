import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:login_form/ragister.dart';
import 'package:sqflite/sqflite.dart';

import 'insurtpage.dart';

class viewpage extends StatefulWidget {


  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  Database? db;
  bool status = false;
  List<Map<String, Object?>> l = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  // Future<bool> goback() {
  //   Navigator.pushReplacement(context, MaterialPageRoute(
  //     builder: (context) {
  //       return ragister("Insert");
  //     },
  //   ));
  //   return Future.value();
  // }

  getdata() async {
    db = await DBHelper().createDatabase();
    String qur = "select * from Test";
    List<Map<String, Object?>> x = await db!.rawQuery(qur);
    l.addAll(x);
    status = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ragister("insert");
            },));

          }, icon:Icon(Icons.add))
        ],
      ),
      body: status
          ? (l.length > 0
              ? PageView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    Map m = l[index];
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.blue.withOpacity(0.5),
                            padding: EdgeInsets.only(top: 80, left: 20),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 30, bottom: 30, top: 40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(80),
                                  topLeft: Radius.circular(80),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 50.0,
                                  ),
                                ],
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: ListView(
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(onPressed: () {

                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return ragister("update",m);
                                        },));

                                      }, child:Text("Update")),
                                    ),
                                    Container(
                                      height: 50,
                                    alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(

                                          border: Border(bottom:BorderSide(width:2,color: Colors.grey.withOpacity(0.5)))
                                      ),
                                      child: Text("Id:${m['id']}"),

                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(

                                          border: Border(bottom:BorderSide(width:2,color: Colors.grey.withOpacity(0.5)))
                                      ),
                                      child: Text("Name:${m['name']}"),

                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(

                                          border: Border(bottom:BorderSide(width:2,color: Colors.grey.withOpacity(0.5)))
                                      ),
                                      child: Text("Email:${m['email']}"),

                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(

                                          border: Border(bottom:BorderSide(width:2,color: Colors.grey.withOpacity(0.5)))
                                      ),
                                      child: Text("Contact=${m['contact']}"),

                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(

                                          border: Border(bottom:BorderSide(width:2,color: Colors.grey.withOpacity(0.5)))
                                      ),
                                      child: Text("Password:${m['password']}"),

                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(

                                          border: Border(bottom:BorderSide(width:2,color: Colors.grey.withOpacity(0.5)))
                                      ),
                                      child: Text("Confirms:${m['confirms']}"),

                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(

                                          border: Border(bottom:BorderSide(width:2,color: Colors.grey.withOpacity(0.5)))
                                      ),
                                      child: Text("Gender:${m['Gender']}"),

                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(

                                          border: Border(bottom:BorderSide(width:2,color: Colors.grey.withOpacity(0.5)))
                                      ),
                                      child: Text("Birthdate:${m['birthdate']}"),

                                    ),
                                    SizedBox(
                                      child: ElevatedButton(onPressed: () {
                                              showDialog(context: context, builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Delete"),
                                                  content: Text(
                                                      "Are you soure to delete File"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          int id = m['id'];
                                                          print(id);

                                                          db!.rawDelete(
                                                              "delete from Test where id =?",
                                                              [
                                                                id
                                                              ]).then(
                                                              (value) {
                                                            l.removeAt(
                                                                index);
                                                            setState(() {});
                                                          });
                                                        },
                                                        child: Text("Yes")),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("No")),
                                                  ],
                                                );
                                              },
                                            );
                                          }, child: Text("Delete")),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );

                  },
                )
              : Center(
                  child: Text("no data founded"),
                ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
