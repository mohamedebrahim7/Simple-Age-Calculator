import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Myprovider>(
      create: (BuildContext context) {
        return Myprovider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final dateController1 = TextEditingController();
  final dateController2 = TextEditingController();
   DateTime date1 ,date2 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Age Calculator"),),
        ),
        body:
        SingleChildScrollView(
             child: Column(

              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  alignment: Alignment.center,
                  child: Text("Date Of Birth", style: TextStyle(fontSize: 25,color: Colors.black26)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      readOnly: true,
                      controller: dateController1,
                      decoration: InputDecoration(
                        hintText: ' Select Your Birth Date',
                        border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                          )

                      ),
                      onTap: () async {
                         date1 =  await showDatePicker(
                            context: context,
                            initialDate:DateTime.parse("1999-04-25"),
                            firstDate:DateTime(1900),
                            lastDate: DateTime(2100));
                        dateController1.text = date1.toString().substring(0,10);
                      }),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  alignment: Alignment.center,
                  child: Text("Today's Date", style: TextStyle(fontSize: 25,color: Colors.black26)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      readOnly: true,
                      controller: dateController2,
                      decoration: InputDecoration(
                        hintText: " Today's Date  ",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                        ),

                      ),
                      onTap: () async {
                           date2 =  await showDatePicker(
                            context: context,
                            initialDate:DateTime.now(),
                            firstDate:DateTime(1900),
                            lastDate: DateTime(2100));
                        dateController2.text = date2.toString().substring(0,10);
                      }),
                ),
                Row(
                    children:<Widget>[
                      Expanded(
                        child: Container(
                              height: 60.0,
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: RaisedButton(
                                  child: Text("Clear", style:TextStyle(fontSize: 20),),
                                  onPressed: (){
                                    Provider.of<Myprovider>(context, listen: false).clear();
                                  },
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(8.0), ),
                              ),
                      ),

                      Expanded(
                        child: Container(
                              height: 60.0,
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child:RaisedButton( child: Text("Calculte", style:TextStyle(fontSize: 20),),
                                onPressed: (){
                                  if(date1==null || date2==null){
                                    final snackBar = SnackBar(
                                      content: Text('please fill all fileds'),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () {
                                          Scaffold.of(context).hideCurrentSnackBar();
                                        },
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }

                                  else if(date1.isAfter(date2)){
                                    final snackBar = SnackBar(
                                      content: Text("Error,please enter an older birthday "),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () {
                                          Scaffold.of(context).hideCurrentSnackBar();
                                        },
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                  else{
                                    Provider.of<Myprovider>(context, listen: false).calculte(date1, date2);
                                  }

                                },
                                color: Colors.blue,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(8.0), ),
                            ),
                      )


                    ]
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0,15, 0, 15),
                  alignment: Alignment.center,
                  child: Text("Age is ", style: TextStyle(fontSize: 25,color: Colors.black26)),
                ),

             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
               Flexible(
                   child: Stack(
                     children:[
                       Container(
                         padding: EdgeInsets.fromLTRB(0,3,0,0),
                         alignment: Alignment.topCenter,
                         height: 70,
                         width: 100,
                         color: Colors.blue,
                         child: Text('Years',
                           style: TextStyle(color: Colors.white, fontSize: 20),
                         ),
                       ),

                       Positioned(
                         top: 30,
                         left:3,
                         right:3,
                         bottom:3,

                         child: Container(
                           height: 40,
                           width: 120,
                           color: Colors.white,
                           child: Center(
                               child: Consumer<Myprovider>(builder: (context, myprovider, child) {
                                 return Text('${myprovider.year}');
                               })
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
                 Flexible(
                 child: Stack(
                   children: <Widget>[
                     // Max Size Widget
                     Container(
                       padding: EdgeInsets.fromLTRB(0,3,0,0),
                       alignment: Alignment.topCenter,
                       height: 70,
                       width: 100,
                       color: Colors.blue,
                       child: Text('Months',
                         style: TextStyle(color: Colors.white, fontSize: 20),
                       ),
                     ),

                     Positioned(
                       top: 30,
                       left:3,
                       right:3,
                       bottom:3,

                       child: Container(
                         height: 40,
                         width: 120,
                         color: Colors.white,
                         child: Center(
                             child: Consumer<Myprovider>(builder: (context, myprovider, child) {
                               return Text('${myprovider.month}');
                             })
                         ),
                       ),
                     )
                   ],
                 ),
               ),
               Flexible(
                 child: Stack(
                   children: <Widget>[
                     // Max Size Widget
                     Container(
                       padding: EdgeInsets.fromLTRB(0,3,0,0),
                       alignment: Alignment.topCenter,
                       height: 70,
                       width: 100,
                       color: Colors.blue,
                       child: Text('Days',
                         style: TextStyle(color: Colors.white, fontSize: 20),
                       ),
                     ),

                     Positioned(
                       top: 30,
                       left:3,
                       right:3,
                       bottom:3,

                       child: Container(
                         height: 40,
                         width: 120,
                         color: Colors.white,
                         child: Center(
                             child: Consumer<Myprovider>(builder: (context, myprovider, child) {
                               return Text('${myprovider.day}');
                             })
                         ),
                       ),
                     )
                   ],
                 ),
               )
               ],
             ),
                Container(
                  margin: EdgeInsets.fromLTRB(0,15, 0, 15),
                  alignment: Alignment.center,
                  child: Text("Next BirthDay in ", style: TextStyle(fontSize: 25,color: Colors.black26)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Stack(
                        children:[
                          Container(
                            padding: EdgeInsets.fromLTRB(0,3,0,0),
                            alignment: Alignment.topCenter,
                            height: 70,
                            width: 100,
                            color: Colors.blue,
                            child: Text('Years',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),

                          Positioned(
                            top: 30,
                            left:3,
                            right:3,
                            bottom:3,

                            child: Container(
                              height: 40,
                              width: 120,
                              color: Colors.white,
                              child: Center(
                                  child: Consumer<Myprovider>(builder: (context, myprovider, child) {
                                    return Text('${myprovider.byear}');
                                  })
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Stack(
                        children: <Widget>[
                          // Max Size Widget
                          Container(
                            padding: EdgeInsets.fromLTRB(0,3,0,0),
                            alignment: Alignment.topCenter,
                            height: 70,
                            width: 100,
                            color: Colors.blue,
                            child: Text('Months',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),

                          Positioned(
                            top: 30,
                            left:3,
                            right:3,
                            bottom:3,

                            child: Container(
                              height: 40,
                              width: 120,
                              color: Colors.white,
                              child: Center(
                                  child: Consumer<Myprovider>(builder: (context, myprovider, child) {
                                    return Text('${myprovider.bmonth}');
                                  })
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Stack(
                        children: <Widget>[
                          // Max Size Widget
                          Container(
                            padding: EdgeInsets.fromLTRB(0,3,0,0),
                            alignment: Alignment.topCenter,
                            height: 70,
                            width: 100,
                            color: Colors.blue,
                            child: Text('Days',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),

                          Positioned(
                            top: 30,
                            left:3,
                            right:3,
                            bottom:3,

                            child: Container(
                              height: 40,
                              width: 120,
                              color: Colors.white,
                              child: Center(
                                  child: Consumer<Myprovider>(builder: (context, myprovider, child) {
                                    return Text('${myprovider.bday}');
                                  })
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )




              ],
          ),
           ),
        ) ;
    //


  }



}