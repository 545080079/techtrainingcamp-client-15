import 'package:techtrainingcamp_client_15/weather/d9l.dart';
import 'package:techtrainingcamp_client_15/weather/model.dart';
import 'package:techtrainingcamp_client_15/weather/change_language_page.dart';
import 'package:techtrainingcamp_client_15/weather/search_page.dart';
import 'package:techtrainingcamp_client_15/weather/sp_client.dart';
import 'package:techtrainingcamp_client_15/weather/home_page_store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    D9l().lang = Localizations.localeOf(context).languageCode;
    SpClient.sp.setString('lang', D9l().lang);
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.png"),fit: BoxFit.cover)),
      child:Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Observer(
          builder: (_) => Text(
            '${homePageStore.basic?.location}',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white,size:30,),
            onPressed: () {
              onSetting(context);
            },
          )
        ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: RefreshIndicator(
          onRefresh: _pullDownRefresh,
          child: ListView(
            children: <Widget>[
             Observer(
              builder: (_) =>Container(
                height: 380.0,
                ///装饰背景图片
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    alignment: Alignment.topCenter,
                    image: new AssetImage("assets/weathernow/${homePageStore.now?.condCode}.webp"),
                    fit: BoxFit.cover,
                  ),
                ),

                child: new Column(
                  ///最小大小，根据children计算
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  ///主体居中
                  children: <Widget>[
                    ///温度
                    Text(
                      "${homePageStore.now?.tmp}℃",
                      style: new TextStyle(fontSize: 54.0,color: Colors.black54),
                    ),
                    ///天气描述
                    Text(
                      '${homePageStore.now?.condTxt}',
                      style: new TextStyle(fontSize: 28.0, color: Colors.black54),
                    ),

                    Padding(
                      padding: new EdgeInsets.symmetric(vertical: 40.0),
                    ),
                    Text(
                      '${AppLocalizations.of(context).tr('air')}  ${homePageStore.airQuality?.qlty}·${homePageStore.airQuality?.aqi}',
                      style: TextStyle(fontSize: 22.0, color: Colors.black54),
                    )
                  ],
                ),
              ),
             ),

              SizedBox(height: 30.0),
              //未来三天天气情况
              Observer(
                builder: (_) => Row(
                  children: homePageStore.dailyForecastList.map((item) => _threeDayWeather(item)).toList(),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: Color(0x33ffffff),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Observer(
                  builder: (_) => Row(
                    children: <Widget>[
                      _centerWidget(
                        icon: 'assets/images/wind_direction.png',
                        title: AppLocalizations.of(context).tr('wind'),
                        data: '${homePageStore.now?.windDir}',
                      ),
                      _centerWidget(
                        icon: 'assets/images/humidity.png',
                        title: AppLocalizations.of(context).tr('humidity'),
                        data: '${homePageStore.now?.hum}%',
                      ),
                      _centerWidget(
                        icon: 'assets/images/air_pressure.png',
                        title: AppLocalizations.of(context).tr('pressure'),
                        data: '${homePageStore.now?.pres}hpa',
                      ),
                      _centerWidget(
                        icon: 'assets/images/somatosensory.png',
                        title: AppLocalizations.of(context).tr('apparent'),
                        data: '${homePageStore.now?.fl}℃',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: const EdgeInsets.only(bottom: 2.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white)),
                ),
                child: Text(AppLocalizations.of(context).tr('lifestyle'), style: TextStyle(fontSize: 16.0, color: Colors.white)),
              ),
              Observer(
                builder: (_) => GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  children: homePageStore.lifeStyleList.where((element) => homePageStore.lsType[element.type] != null).map((element) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0x33ffffff),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(homePageStore.lsType[element.type], style: TextStyle(color: Colors.white)),
                          SizedBox(height: 3.0),
                          Text(element.brf, style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }

  Widget _centerWidget({String icon, String title, String data}) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Image.asset(icon, width: 24.0, fit: BoxFit.fill),
          SizedBox(height: 4.0),
          Text(title, style: TextStyle(color: Colors.white)),
          SizedBox(height: 4.0),
          Text(data, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _threeDayWeather(DailyForecast dailyForecast) {
    String date = DateFormat('EE', D9l().lang).format(DateTime.parse(dailyForecast.date));
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(date, style: TextStyle(color: Colors.white)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Image.asset('assets/images/weather/${dailyForecast.condCodeD}.png', color: Colors.white),
          ),
          Text(dailyForecast.condTxtD, style: TextStyle(color: Colors.white)),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(dailyForecast.tmpMin + '℃~' + dailyForecast.tmpMax + '℃', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void onSetting(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(AppLocalizations.of(context).tr('change_city')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, CupertinoPageRoute(builder: (_) => SearchPage())).then((result) {
                  if (result == true) {
                    homePageStore.getWeather();
                  }
                });
              },
            ),
            Divider(height: 0.0),
            ListTile(
              title: Text(AppLocalizations.of(context).tr('change_language')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, CupertinoPageRoute(builder: (_) => ChangeLanguagePage()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pullDownRefresh() async {
    bool result = await homePageStore.getWeather();
    if (result) Fluttertoast.showToast(msg: D9l.toastStr[D9l().lang]['update']);
  }
}
