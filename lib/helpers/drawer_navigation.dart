import 'package:flutter/material.dart';
import 'package:moneyist/screens/categories_screen.dart';
import 'package:moneyist/screens/home_screen.dart';
import 'package:moneyist/screens/todos_by_category.dart';
import 'package:moneyist/services/category_service.dart';
import 'package:moneyist/view/settings.dart';

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
                  builder: (context) => new TodosByCategory(category: category['name'],))),
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
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqVfDOgQfu8ALkyynwaWKlFF0WusqZ_GOWXj1uWG5KWSpSSkIPgoUZX2KOs8NTIOVOp5E&usqp=CAU'),
              ),
              accountName: Text('FLutter TODO'),
              accountEmail: Text('SQFLITE'),
              decoration: BoxDecoration(color: Colors.teal),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen()));
              },
            ),ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Settings())),
            ),
            Divider(),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
