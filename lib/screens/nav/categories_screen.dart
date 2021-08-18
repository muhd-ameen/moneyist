import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyist/models/category.dart';
import 'package:moneyist/screens/home_screen.dart';
import 'package:moneyist/test/Home.dart';
import 'package:moneyist/services/category_service.dart';
import 'package:toast/toast.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = List<Category>();

  var category;

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();
  TabController _controller;

  @override
  void initState() {
    super.initState();
    getAllCategories();
    _controller = new TabController(length: 2, vsync: this);
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          category[0]['description'] ?? 'No Description';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                color: Colors.indigoAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () async {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;

                  var result = await _categoryService.saveCategory(_category);
                  if (result > 0) {
                    print(result);
                    getAllCategories();
                    // Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text('categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Write a category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showToast(String msg) {
    Toast.show(msg, context, duration: 2, gravity: Toast.BOTTOM);
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                color: Colors.indigoAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = _editCategoryNameController.text;
                  _category.description =
                      _editCategoryDescriptionController.text;

                  var result = await _categoryService.updateCategory(_category);
                  if (result > 0) {
                    getAllCategories();
                    showToast('Updated');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text('Edit Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Write a category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _editCategoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () async {
                  var result =
                      await _categoryService.deleteCategory(categoryId);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                    showToast('Deleted');
                  }
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text('Are you sure you want to delete this?'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
            child: new TabBar(
              controller: _controller,
              tabs: [
                new Tab(
                  icon: const Icon(Icons.money_off),
                  text: 'Income',
                ),
                new Tab(
                  icon: const Icon(Icons.transfer_within_a_station),
                  text: 'Expense',
                ),
              ],
            ),
          ),
          new Container(
            height: 600.0,
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[
                new ListView.builder(
                    itemCount: _categoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                        child: Card(
                          elevation: 8.0,
                          child: ListTile(
                            leading: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editCategory(context, _categoryList[index].id);
                                }),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(_categoryList[index].name),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _deleteFormDialog(context, _categoryList[index].id);
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                new ListView.builder(
                    itemCount: _categoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                        child: Card(
                          elevation: 8.0,
                          child: ListTile(
                            leading: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editCategory(context, _categoryList[index].id);
                                }),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(_categoryList[index].name),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _deleteFormDialog(context, _categoryList[index].id);
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
      //
      // body:
      // ListView.builder(
      //     itemCount: _categoryList.length,
      //     itemBuilder: (context, index) {
      //       return Padding(
      //         padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
      //         child: Card(
      //           elevation: 8.0,
      //           child: ListTile(
      //             leading: IconButton(
      //                 icon: Icon(Icons.edit),
      //                 onPressed: () {
      //                   _editCategory(context, _categoryList[index].id);
      //                 }),
      //             title: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: <Widget>[
      //                 Text(_categoryList[index].name),
      //                 IconButton(
      //                     icon: Icon(
      //                       Icons.delete,
      //                       color: Colors.red,
      //                     ),
      //                     onPressed: () {
      //                       _deleteFormDialog(context, _categoryList[index].id);
      //                     })
      //               ],
      //             ),
      //           ),
      //         ),
      //       );
      //     }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
