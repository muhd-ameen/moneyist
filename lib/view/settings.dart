import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:moneyist/helpers/notification/notificationApi.dart';
import 'package:moneyist/helpers/notification/secondPage.dart';
import 'package:moneyist/repositories/repository.dart';
import 'package:moneyist/screens/home_screen.dart';
import 'package:moneyist/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

bool notification = false;

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    // listenNotification();
  }
  // bool notification = false;

  void listenNotification() =>
      NotificationApi.onNotifications.listen(onClickedNotification);
  void onClickedNotification(String payload) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SecondPage(
                payload: payload,
              )));

  NotificationOn() {
    return NotificationApi.showNotification(
      title: 'Daily Notification Enabled!',
      body:
          "Hooray It's an Great Move! Start Adding Your Daily Transactions :)",
      payload: 'Moneyist.abs',
    );
  }

  NotificationOff() {
    return NotificationApi.showNotification(
      title: 'Daily Notification Disabled!',
      body: "😢 Ho Hah, Take Some Rest & come back with more Power :(",
      payload: 'Moneyist.abs',
    );
  }

  var model = Repository();

  removePreferenceValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', false);
  }

  @override
  addPreferenceValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notification', notification);
  }
  @override
 remPreferenceValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notification', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        if (notification == true) {
                          addPreferenceValues();
                          print(notification.toString());
                          NotificationOn();
                        } else {
                          print(notification.toString());
                          NotificationOff();
                        }
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            notification == false
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Turn off Reminder',
                        style: TextStyle(
                            color: Color(0xFF606060),
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          NotificationApi.cancelAll();
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.black45,
                        ),
                      )
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
                  onPressed: () async {
                    await showToast(
                        'All Data in This Application As Been Deleted');
                    Future.delayed(const Duration(milliseconds: 3000),
                        () async {
                      await model.deleteDb();
                      await model.deleteDbc();
                      removePreferenceValues();
                      remPreferenceValues();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SplashScreen()));
                    });

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

  void showToast(String msg) {
    Toast.show(msg, context, duration: 3, gravity: Toast.BOTTOM);
  }
}
