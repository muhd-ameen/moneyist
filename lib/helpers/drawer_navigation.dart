import 'package:flutter/material.dart';
import 'package:moneyist/screens/nav/categories_screen.dart';
import 'package:moneyist/screens/home_screen.dart';
import 'package:moneyist/screens/todos_by_category.dart';
import 'package:moneyist/services/category_service.dart';
import 'package:moneyist/view/settings.dart';
import 'package:share/share.dart';

class DrawerNavigaton extends StatefulWidget {
  @override
  _DrawerNavigatonState createState() => _DrawerNavigatonState();
}

class _DrawerNavigatonState extends State<DrawerNavigaton> {
  List<Widget> _categoryList = List<Widget>();

  CategoryService _categoryService = CategoryService();

  @override
  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();

    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new TodosByCategory(
                        category: category['name'],
                      ))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/navimg.jpg"),
                  ),
                  // color: Colors.teal,
                ),
                child: null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.teal),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.category_outlined),
              title: Text('Categories'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoriesScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.get_app_outlined, color: Colors.deepPurple),
              title: Text('Export Data'),
              onTap: () {
                Navigator.pushNamed(context, '/ExportData');
              },
            ),
            ListTile(
              leading: Icon(Icons.star_outline_outlined, color: Colors.orange),
              title: Text('Rate Us'),
              onTap: () {
                Navigator.pushNamed(context, '/Rating');
              },
            ),
            ListTile(
              leading: Icon(Icons.mobile_screen_share_outlined,
                  color: Colors.blueAccent),
              title: Text('Share App'),
              onTap: () {
                Share.share(
                    'check out The Moneyist website https://example.com',
                    subject: 'Look what I made!');
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outlined, color: Colors.deepPurple),
              title: Text('About Us'),
              onTap: () {
                Navigator.pushNamed(context, '/Support');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings())),
            ),
            Divider(),
            Center(
                child: Text(
              'Category List',
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
