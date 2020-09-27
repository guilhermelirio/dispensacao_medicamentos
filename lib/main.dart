import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/inicial.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hasura + GetX',
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.red, //  <-- dark color
          )),
      debugShowCheckedModeBanner: false,
      home: InitialPage(),
    );
  }
}
