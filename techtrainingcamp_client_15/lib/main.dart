import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:techtrainingcamp_client_15/luoyutao/BottomNavigationWidget.dart';




void main() {
  runApp(ClockApp());
}

class ClockApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'My Clock',
        debugShowCheckedModeBanner: false, //不显示debug图标
        theme: ThemeData.light(),
        home: BottomNavigationWidget()
    );
  }



}
//    return MaterialApp(//根组件
//      title: 'My Clock',
//      debugShowCheckedModeBanner: false, //不显示debug图标
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home:WillPopScope(
//        onWillPop: () async {
//        return true;  //一定要return false
//        },
//        child: Tabs(),
//      )
//
////      routes: {   //命名路由，需要在主目录配置一下
////        "/":(context)=>Tabs(),
////        "/alarm":(context)=>AlarmClockPage(),
////        '/alarm_detail':(context)=>AlarmDetail()
////      },
////      onGenerateRoute: ,
//
//    );
//  }
//}
