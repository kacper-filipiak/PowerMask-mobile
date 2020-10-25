
import 'package:flutter/widgets.dart';

import 'SignedInPage.dart';
import 'package:powermaskmobile/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth.dart';
import 'data_recever.dart';


class ChartPage extends StatelessWidget {

  Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(50, 50, 50, 50),
      body: Stack(
        children: [
          Flexible(child: FlatButton(onPressed:()=> Get.back(), child: Container(),)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TimeLineFromTime(Colors.tealAccent, context.width),
                    Row(

                      children: [
                        Expanded(child: IconButton(icon: Icon(Icons.arrow_back_ios_outlined), onPressed: ()=>{controller.sessionNumberAdd(),Get.to(ChartPage())})),
                        Expanded(child: IconButton(icon: Icon(Icons.arrow_forward_ios_outlined), onPressed: ()=>{controller.sessionNumberSub(),Get.to(ChartPage())})),

                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
Widget TimeLineFromTime(Color color, width, [int sessin = 0]){
  Controller controller = Get.find();
  return Column(

      children: [
        Text(controller.dateTimeMap[controller.sessionNumber.value][0].dateTime.toString()),
          SizedBox(
            width: width,
            height: 300,
            child: Expanded(
              child: Container(
                child: ListView.builder(

                  itemCount: controller?.dateTimeMap==null?0:controller.dateTimeMap.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext bctx, index) {
                    return
                    Row(
                      children: [
                        Container(color:color,child: SizedBox(height: 50,width: controller.dateTimeMap[controller.sessionNumber.value][index].timeFromLast.abs().toDouble() ,)),
                        Text("${controller.dateTimeMap[controller.sessionNumber.value][index].dateTime.hour.toString()}:${controller.dateTimeMap[controller.sessionNumber.value][index].dateTime.minute.toString()}"),

                    ],
                    );

                  },
                ),
              ),
            ),
          ),


      ],
    );

}

