import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techtrainingcamp_client_15/luoyutao/BottomNavigationWidget.dart';
import 'package:techtrainingcamp_client_15/weather/d9l.dart';
import 'package:techtrainingcamp_client_15/weather/sp_client.dart';
import 'package:techtrainingcamp_client_15/weather/home_page_store.dart';
import 'package:easy_localization/easy_localization.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([SpClient.getInstance()]).then((_) async {
    if (SpClient.sp.getString('cid') == null) {
      SpClient.sp.setString('cid', 'CN101280101'); // 第一次安装APP默认显示广州天气
    }
    homePageStore.cid = SpClient.sp.getString('cid');
    D9l().lang = SpClient.sp.getString('lang') ?? 'zh';
    await homePageStore.getWeather();
    runApp(EasyLocalization(child:ClockApp() ));
  });
}

class ClockApp extends StatelessWidget {
  // This widget is the root of your application.
  static GlobalKey<NavigatorState> navigatorKey=GlobalKey();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'My Clock',
        debugShowCheckedModeBanner: false, //不显示debug图标
        theme: ThemeData.light(),
        home: BottomNavigationWidget(),
        navigatorKey:navigatorKey,

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
