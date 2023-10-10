import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inngage_plugin/inngage_plugin.dart';
import 'home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  initSdk() async {
    final json = {
      "nome": "User 01",
      "dt_nascimento": "01/09/1970",
      "genero": "M",
      "cartao": "N",
      "ultimo_abastecimento": "10/09/2018",
      "total_abastecido": "290,00"
    };

    final inngageWebViewProperties = InngageWebViewProperties(
      appBarColor: Colors.pink,
      appBarText: const Text(
        'AppTitle',
      ),
      backgroundColor: Colors.white,
      loaderColor: Colors.pink,
      debuggingEnabled: true,
      withJavascript: true,
      withLocalStorage: true,
      withZoom: true,
    );
    await InngageSDK.subscribe(
      appToken: '4ea9fe3da3a29119b81a2832806aedd3',
      friendlyIdentifier: 'inngage_teste',
      customFields: json,
      phoneNumber: '5511999999999',
      email: 'inngage@inngage.com.br',
      blockDeepLink: false,
      firebaseListenCallback: (data) => log(data['additional_data']),
      navigatorKey: navigatorKey,
      inngageWebViewProperties: inngageWebViewProperties,
      requestAdvertiserId: false,
    );
    Future.delayed(const Duration(seconds: 5)).then((value) {
      InngageNotificationMessage.subscribe();
    });

    /*InngageUtils.addUserData(
        identifier: 'user02@inngage.com.br',
        customFields: {
          "nome": "User 02",
          "dt_nascimento": "02/10/1971",
          "genero": "F",
          "cartao": "NN",
          "ultimo_abastecimento": "11/10/2019",
          "total_abastecido": "300,00"
        });*/

    InngageInapp.blockDeepLink = true;
    InngageInapp.deepLinkCallback = (link) {
      log('link: $link');
    };
  }

  @override
  void initState() {
    super.initState();
    initSdk();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const InngageInAppWidget(child: HomePage()),
    );
  }
}
