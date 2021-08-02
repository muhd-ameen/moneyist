import 'package:flutter/material.dart';
import 'package:moneyist/view/add_category.dart';
import 'package:moneyist/view/support.dart';

import 'view/add_transaction.dart';
import 'view/edit_transaction.dart';
import 'view/export_data.dart';
import 'view/home.dart';
import 'view/rating.dart';
import 'view/settings.dart';
import 'view/splash_screen.dart';
import 'view/welcome.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext ctx) => SplashScreen(),
        '/welcome': (BuildContext ctx) => Welcome(),
        '/home': (BuildContext ctx) => Home(),
        '/setting': (BuildContext ctx) => Settings(),
        '/AddTransaction': (BuildContext ctx) => AddTransaction(),
        '/AddCategory': (BuildContext ctx) => AddCategory(),
        '/ExportData': (BuildContext ctx) => ExportData(),
        '/Support': (BuildContext ctx) => Support(),
        '/EditTransaction': (BuildContext ctx) => EditTransaction(),
        '/Rating': (BuildContext ctx) => Rating(),
      },
    );
  }
}