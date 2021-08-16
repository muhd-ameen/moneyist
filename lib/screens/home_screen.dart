import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneyist/view/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moneyist/helpers/drawer_navigation.dart';
import 'package:moneyist/screens/todo_screen.dart';
import 'package:moneyist/screens/nav/home.dart';
import 'package:toast/toast.dart';
import 'nav/categories_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notification = prefs.getBool('notification');
    });
  }

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    CrudHome(),
    CategoriesScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime timeLastPressed = DateTime.now();

  void showToast(String msg) {
    Toast.show(msg, context, duration: 2, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final difference = DateTime.now().difference(timeLastPressed);
        final isExitWaring = difference >= Duration(seconds: 2);
        timeLastPressed = DateTime.now();

        if (isExitWaring) {
          showToast('press back again to exit');
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            SystemNavigator.pop();
          });
        }
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoScreen())),
          child: Icon(Icons.add),
        ),
        drawer: DrawerNavigaton(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard_customize_outlined,
              ),
              title: Text('Category'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
