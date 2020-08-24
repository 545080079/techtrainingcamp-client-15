import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:techtrainingcamp_client_15/weather/d9l.dart';
import 'package:techtrainingcamp_client_15/weather/pages/home_page.dart';
import 'package:techtrainingcamp_client_15/weather/sp_client.dart';
import 'package:techtrainingcamp_client_15/weather/store/home_page_store.dart';

class WeatherScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WeatherState();
  }
}
class _WeatherState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    Future.wait([SpClient.getInstance()]).then((_) async {
      if (SpClient.sp.getString('cid') == null) {
        SpClient.sp.setString('cid', 'CN101280101'); // 第一次安装APP默认显示广州天气
      }
      homePageStore.cid = SpClient.sp.getString('cid');
      D9l().lang = 'zh';
      SpClient.sp.setString('lang', 'zh');
      await homePageStore.getWeather();
    });

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        title: 'd9l weather',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasylocaLizationDelegate(
            locale: data.locale,
            path: 'assets/langs', // 多语言路径
          ),
        ],
        supportedLocales: [Locale('en', 'US'), Locale('zh', 'CN')],
        locale: data.savedLocale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}



