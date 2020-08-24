import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:techtrainingcamp_client_15/weather/d9l.dart';
import 'package:techtrainingcamp_client_15/weather/home_page.dart';
import 'package:techtrainingcamp_client_15/weather/sp_client.dart';
import 'package:techtrainingcamp_client_15/weather/home_page_store.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
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