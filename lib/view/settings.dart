import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:moneyist/repositories/repository.dart';
import 'package:moneyist/screens/home_screen.dart';
import 'package:moneyist/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var model = Repository();

  removePreferenceValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', false);
  }

  bool notification = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Turn on Reminder',
                  style: TextStyle(
                      color: Color(0xFF606060),
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ),
                FlutterSwitch(
                    activeColor: Color(0xFF4cd964),
                    width: 50.0,
                    height: 25.0,
                    toggleSize: 15.0,
                    borderRadius: 30.0,
                    padding: 4.0,
                    value: notification,
                    onToggle: (val) {
                      setState(() {
                        notification = val;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rest App',
                  style: TextStyle(
                      color: Color(0xFF606060),
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    removePreferenceValues();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => SplashScreen()  ));
                    // await model.deleteDb('transactions');
                    // SystemNavigator.pop();
                  },
                  icon: Icon(
                    Icons.restart_alt,
                    size: 30,
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 150),
              child: Image.asset('assets/images/settings.png'),
            )
          ],
        ),
      ),
    );
  }
}
