import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_form/insurtpage.dart';
import 'package:login_form/viewpage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:validators/validators.dart';

class ragister extends StatefulWidget {
  Map? m;
  String? s;
  ragister(this.s,[this.m]);



  @override
  State<ragister> createState() => _ragisterState();
}

class _ragisterState extends State<ragister> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController contect=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController tdate=TextEditingController();





  bool isObscure=true;
  bool val =true;
  String num="";
  bool isANumber = true;
  String male="Male";
  String female="Female";
  String gvalue="Male";
  bool emaill=false;
  int index=-1;

  String countlist ="1";
  Database? db;
  @override
  void dispose() {
    // TODO: implement initState
    super.initState();
    email.dispose();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.s=="update")
    {
      name.text=widget.m!['name'];
      email.text=widget.m!['email'];
      contect.text=widget.m!['contact'];
      t1.text=widget.m!['password'];
      t2.text=widget.m!['confirms'];
      gvalue=widget.m!['Gender'];
      tdate.text=widget.m!['birthdate'];

    }
    DBHelper().createDatabase().then((value){
      db =value;
      print(value);


    });
  }
  Future<bool> goback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return viewpage();
      },
    ));
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child:GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return viewpage();
              },));
          }, icon:Icon(Icons.arrow_back_ios)),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue.withOpacity(0.5),
                  padding: EdgeInsets.only(top: 80,left: 20),
                  child: Container(
                    padding: EdgeInsets.only(left: 30,bottom: 30,top: 60),

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
                    child:Container(
                      alignment: Alignment.center,

                      child:  ListView(

                        children: [

                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: ListTile(
                              title: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: name,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    helperText:"Full Name",
                                    errorText: null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: ListTile(

                              title: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: email,
                                  onChanged: (value) {

                                    setState(() {
                                      emaill=isEmail(value);
                                    });
                                  },
                                  textCapitalization: TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    helperText: "abc@gmail.com",
                                    suffix: IconButton(onPressed: () {

                                    }, icon:Icon(Icons.done),color: emaill==false?
                                    Colors.red:Colors.green,
                                    ),

                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: ListTile(
                              title: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: contect,
                                  maxLength: 10,
                                  onChanged: (value) {

                                  },

                                  keyboardType:TextInputType.numberWithOptions(decimal: true,signed: true),
                                  decoration: InputDecoration(
                                    hintText: "Contect",
                                    helperText: "10 digit Number",


                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: ListTile(
                              title: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: t1,
                                  obscureText:isObscure,
                                  keyboardType:TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    helperText: "Use 8 or more characters with a mix of letters, numbers & symbols",
                                    helperMaxLines: 1,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isObscure = !isObscure;
                                        });
                                      },
                                      icon: Icon(isObscure? Icons.visibility : Icons.visibility_off),
                                      alignment: Alignment.topCenter,
                                    ),

                                  ),
                                ),
                              ),

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: ListTile(
                              title: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: t2,
                                  obscureText:val,
                                  keyboardType:TextInputType.visiblePassword,
                                  onChanged: (inputValue){

                                  },
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    helperText: "Confirm Password",
                                    helperMaxLines: 1,
                                    errorText: isANumber ? null : "Please enter a number",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          val = !val;
                                        });
                                      },
                                      icon: Icon(val? Icons.visibility : Icons.visibility_off),
                                      alignment: Alignment.topCenter,
                                    ),

                                  ),

                                ),
                              ),

                            ),
                          ),
                          Container(
                            child: RadioListTile(
                              title: Text(male),
                              value:male , groupValue:gvalue , onChanged: (value) {
                              setState(() {
                                gvalue=value as String;
                              });

                            },

                            ),
                          ),
                          Container(
                            child: RadioListTile(
                              title: Text(female),
                              value:female , groupValue:gvalue , onChanged: (value) {
                              setState(() {
                                gvalue=value as String;
                              });

                            },

                            ),
                          ),

                          Container(
                            child: TextField(
                              controller: tdate,
                              keyboardType:TextInputType.none,
                              decoration: InputDecoration(
                                  hintText: "Birth Date",
                                  suffixIcon: IconButton(onPressed: () {
                                    setState(() {
                                      showCupertinoDatePicker(

                                      );
                                    });
                                  }, icon: Icon(Icons.calendar_today))
                              ),
                            ),
                          ),


                          Container(
                            child: SizedBox(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(

                                  ), onPressed: () async {
                                String tname=name.text;
                                String temail=email.text;
                                String tContect=contect.text;
                                String pass=t1.text;
                                String pss2=t2.text;
                                String date=tdate.text;



                                //String qur="insert into Test(name,email,contact,pass,pass2,)values('$tname','$temail','$tContect','$pass','$pss2')";

                                if(widget.s=="insert")
                                  {
                                    String q="insert into Test(name,email,contact,password,confirms,Gender,birthdate)values('$tname','$temail','$tContect','$pass','$pss2','$gvalue','$date')";
                                    int id= await db!.rawInsert(q);
                                    if(id>0)
                                      {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                          return viewpage();
                                        },));

                                      }

                                  }
                                else
                                  {
                                     String q="update Test set name='$tname',email='$temail',contact='$tContect',password='$pass',confirms='$pss2',Gender='$gvalue',birthdate='$date' where id=${widget.m!['id']}";
                                     int id=await db!.rawUpdate(q);
                                     print(id);
                                     if(id==1)
                                       {
                                         print(id);
                                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                           return viewpage();

                                         },));
                                       }
                                  }




                              }, child:Text("Ragister") ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ), onWillPop:goback);

  }
  void showCupertinoDatePicker()
  {
    showModalBottomSheet(
      context: context, builder: (context) {

      return Container(
        height: 200,
        child: CupertinoDatePicker(

          dateOrder: DatePickerDateOrder.dmy,
          mode: CupertinoDatePickerMode.date,

          initialDateTime: DateTime.now(),
            onDateTimeChanged:(value) {

                tdate.text="${value.day}/${value.month}/${value.year}";

            },
        ),
      );
    },);
  }
}
