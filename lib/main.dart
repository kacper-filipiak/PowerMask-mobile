import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:powermaskmobile/auth.dart';
import 'dart:math';
import 'LoginPage.dart';
import 'SignedInPage.dart';
import 'ChartPage.dart';
import 'data_recever.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


void main() => runApp(GetMaterialApp(home: Home()));

final BIG_TEXT_FACTOR = 2.5;
final MEDIUM_TEXT_FACTOR = 2.0;
final SMAL_TEXT_FACTOR = 1.0;
final LONG_TEXT_FACTOR = 0.5;
class timeData{

}
class timeMember{
  DateTime dateTime;
  int timeFromLast = 0;
}
class Controller extends GetxController{

  Map<int,Map<int,timeMember>> dateTimeMap = Map<int,Map<int,timeMember>>();
  Map<int, List<dynamic>> dataMapList;
  var count = 0.obs;
  var rate = 0.2.obs;
  var time = 0.obs;
  var name = "".obs;
  var email = "".obs;
  var imageUrl = "".obs;
  var signedIn=false.obs;
  var sessionNumber = 1.obs;
  sessionNumberAdd() => sessionNumber--;
  sessionNumberSub() => sessionNumber++;



  int _i = 0;
  GoogleSignIn signInClient = GoogleSignIn();
  increment() => rate+=0.01;
  userDataReadyCall() async => {
    _i=0,

  };

}
void rewriteMap(){
  int o = 0, t = 0;
  Controller controller = Get.find();
  while(o<controller.dataMapList.length){
    while(t<controller.dataMapList[o].length){
      controller.dateTimeMap[o][t].dateTime=DateTime.parse(controller.dataMapList[o][t].toString());
      controller.dateTimeMap[o][t].timeFromLast = controller.dateTimeMap[o][t].dateTime.difference(controller.dateTimeMap[o][t].dateTime).inSeconds;
    }
  }

}
DateTime parseTimestamp(String t){
  int y, m, d, h, mi, s, ms;
  y = int.parse(t.substring(0,4));
  m = int.parse(t.substring(5,7));

  d = int.parse(t.substring(8,10));

  h = int.parse(t.substring(11,13));
  mi = int.parse(t.substring(14,16));
  s = int.parse(t.substring(17,19));
  ms = int.parse(t.substring(20));

  return DateTime(y, m, d, h, mi, s, ms);
}
Future<void> processMap() async {
  Controller controller = Get.find();
  int  _i =1;
  Map<int, timeMember> localMap = Map<int, timeMember>();
  controller.dateTimeMap = Map<int,Map<int,timeMember>>();
  int o = 0, t = 0;
  searchStream(googleSignIn.clientId).then((value) =>
      value.docs.forEach((element) {
      element.data().values.forEach((element) {
        timeMember member = timeMember();
        DateTime tim;
        member.dateTime = parseTimestamp(element);
        member.timeFromLast = t>0? member.dateTime.difference(localMap[t-1].dateTime).inSeconds:0;
        localMap.putIfAbsent(t, () => member);
        t++;
      });
      controller.dateTimeMap.putIfAbsent(o, () => localMap);
      print(controller.dateTimeMap.toString());
      o++;
      if(o>2){
        updateUI();
      }
      } ));


}
void updateUI(){
  Controller controller = Get.find();
  controller.count(controller.dateTimeMap[controller.sessionNumber.value][0].dateTime.difference(controller.dateTimeMap[controller.sessionNumber.value][controller.dateTimeMap[controller.sessionNumber.value].length-1].dateTime).inMinutes.abs());
  controller.time(controller.dateTimeMap[controller.sessionNumber.value][0].dateTime.difference(controller.dateTimeMap[controller.sessionNumber.value][controller.dateTimeMap[controller.sessionNumber.value].length-1].dateTime).inMinutes.abs());
  controller.rate(controller.dateTimeMap[controller.sessionNumber.value][0].dateTime.difference(controller.dateTimeMap[controller.sessionNumber.value][controller.dateTimeMap[controller.sessionNumber.value].length-1].dateTime).inMinutes.abs()/(controller.dateTimeMap[controller.sessionNumber.value].length*60));

}
class Home extends StatelessWidget {

  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  final Controller c = Get.put(Controller());


  @override
  Widget build(context) => Scaffold(
    // Use Obx(()=> to update Text() whenever count is changed.

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Column(

        children: [

          SizedBox(height: 20,),
          TopLoginBar(c, context),
          SizedBox(child: ProgressCircle(c, context),height: context.height/3,),
          SizedBox(child: DisplyRow(c, context), height: context.height/8,)
        ],
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment));
}
Widget TopLoginBar(Controller c, BuildContext context){
  return SizedBox(
    height: context.height/10,
    child: Row(
      children: [
        IconButton(icon: Icon(Icons.info), onPressed: null),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: CircleAvatar(child: Icon(Icons.login_rounded),),
              onPressed: () async =>{await googleSignIn.isSignedIn()&&googleSignIn.currentUser!=null?Get.to(SignedInPage()):Get.to(LoginPage())}),
        ),

      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
    ) ,
  );
}
Widget ValueWithLabel(String label, value){
  return Column(
    children: [
      Center(
        child: Text(roundDouble(value, 1).toString() ,textScaleFactor: MEDIUM_TEXT_FACTOR,),
      ),
      Center(
        child: Text(label, textScaleFactor: SMAL_TEXT_FACTOR,),
      ),
    ],
    mainAxisAlignment: MainAxisAlignment.center,

  );
}
Widget DisplyRow(Controller c, BuildContext context){

  return DecoratedBox(
    child: FlatButton(
      child: Row(
        children: [
          Flexible(child: Center(child: Obx(()=>ValueWithLabel("min", c.time)))),

          Flexible(child: Center(child: Obx(()=>ValueWithLabel("rate", c.rate)))),

          Flexible(child: Center(child: Obx(()=>ValueWithLabel("count", c.count)))),
        ],
      ),
      onPressed: () => Get.to(ChartPage()),
    ),
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 3.0 )]
  ),);
}
Widget ProgressCircle(Controller c, BuildContext context){
  return Stack(
    children: [
      Center(child: Obx(()=>CircularPercentIndicator(
        radius: context.width/2.5,
        lineWidth: context.width/20,
        percent: c.rate.value,
        center: new Text(roundDouble(c.rate.value, 1).toString(), textScaleFactor: BIG_TEXT_FACTOR,),
        progressColor: getProgressColor(c.rate.value),
       backgroundColor: Colors.amberAccent,

      ))),

    ],
  );
}
Color getProgressColor(double rate){
  return Color.fromARGB(255, (180-rate*180).toInt(), pow((rate*120),1.1).toInt(), 0);
}
double roundDouble(value, int places){
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();

  @override
  Widget build(context){
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}
