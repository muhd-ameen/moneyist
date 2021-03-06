import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyist/models/Incomecategory.dart';
import 'package:moneyist/models/expensecategory.dart';
import 'package:moneyist/screens/home_screen.dart';
import 'package:moneyist/services/Income_category_service.dart';
import 'package:moneyist/services/expense_category_service.dart';
import 'package:toast/toast.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  var _incategoryNameController = TextEditingController();
  var _excategoryNameController = TextEditingController();
  var _incategoryDescriptionController = TextEditingController();
  var _excategoryDescriptionController = TextEditingController();

  var _incategory = IncomeCategory();
  var _excategory = ExpenseCategory();
  var _incategoryService = IncomeCategoryService();
  var _excategoryService = ExpenseCategoryService();

  List<IncomeCategory> _incategoryList = List<IncomeCategory>();
  List<ExpenseCategory> _excategoryList = List<ExpenseCategory>();

  var incategory;
  var excategory;
  String _selectedCategory = 'income';

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();
  TabController _controller;
  var _selectedValue;

  @override
  void initState() {
    super.initState();
    getAllInCategories();
    getAllExCategories();
    _controller = new TabController(length: 2, vsync: this);
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllInCategories() async {
    _incategoryList = List<IncomeCategory>();
    var incategories = await _incategoryService.readCategories();
    incategories.forEach((category) {
      setState(() {
        var categoryModel = IncomeCategory();
        categoryModel.inname = category['inname'];
        categoryModel.indescription = category['indescription'];
        categoryModel.id = category['id'];
        _incategoryList.add(categoryModel);
      });
    });
  }

  getAllExCategories() async {
    _excategoryList = List<ExpenseCategory>();
    var excategories = await _excategoryService.readCategories();
    excategories.forEach((category) {
      setState(() {
        var categoryModel = ExpenseCategory();
        categoryModel.exname = category['exname'];
        categoryModel.exdescription = category['exdescription'];
        categoryModel.id = category['id'];
        _excategoryList.add(categoryModel);
      });
    });
  }

  _editInCategory(BuildContext context, categoryId) async {
    incategory = await _incategoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = incategory[0]['inname'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          incategory[0]['indescription'] ?? 'No Description';
    });
    _editInFormDialog(context);
  }

  _editExCategory(BuildContext context, categoryId) async {
    incategory = await _incategoryService.readCategoryById(categoryId);
    excategory = await _excategoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = incategory[0]['inname'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          incategory[0]['indescription'] ?? 'No Description';
    });
    setState(() {
      _editCategoryNameController.text = excategory[0]['exname'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          excategory[0]['exdescription'] ?? 'No Description';
    });
    _editExFormDialog(context);
  }

  _showInFormDialog(BuildContext context) {
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
                  _incategory.inname = _incategoryNameController.text;
                  _incategory.indescription =
                      _incategoryDescriptionController.text;
                  var inresult =
                      await _incategoryService.saveCategory(_incategory);
                  if (inresult > 0) {
                    print(inresult);
                    getAllInCategories();
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
                  Column(
                    children: [
                      TextField(
                        controller: _incategoryNameController,
                        decoration: InputDecoration(
                            hintText: 'Write a category',
                            labelText: 'Income Category'),
                      ),
                      TextField(
                        controller: _incategoryDescriptionController,
                        decoration: InputDecoration(
                            hintText: 'Write a description',
                            labelText: 'Income Description'),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  _showExFormDialog(BuildContext context) {
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
                  _excategory.exname = _excategoryNameController.text;
                  _excategory.exdescription =
                      _excategoryDescriptionController.text;
                  var exresult =
                      await _excategoryService.saveCategory(_excategory);
                  if (exresult > 0) {
                    print(exresult);
                    getAllExCategories();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesScreen()));
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
                  Column(
                    children: [
                      TextField(
                        controller: _excategoryNameController,
                        decoration: InputDecoration(
                            hintText: 'Write a category',
                            labelText: 'Expense Category'),
                      ),
                      TextField(
                        controller: _excategoryDescriptionController,
                        decoration: InputDecoration(
                            hintText: 'Write a description',
                            labelText: 'Expense Description'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showToast(String msg) {
    Toast.show(msg, context, duration: 2, gravity: Toast.BOTTOM);
  }

  _editInFormDialog(BuildContext context) {
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
                  _incategory.id = incategory[0]['id'];
                  _incategory.inname = _editCategoryNameController.text;
                  _incategory.indescription =
                      _editCategoryDescriptionController.text;
                  var inresult =
                      await _incategoryService.updateCategory(_incategory);
                  if (inresult > 0) {
                    getAllInCategories();
                    showToast('Updated');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoriesScreen()));
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

  _editExFormDialog(BuildContext context) {
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
                  _excategory.id = excategory[0]['id'];
                  _excategory.exname = _editCategoryNameController.text;
                  _excategory.exdescription =
                      _editCategoryDescriptionController.text;
                  var exresult =
                      await _excategoryService.updateCategory(_excategory);
                  if (exresult > 0) {
                    getAllExCategories();
                    showToast('Updated');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoriesScreen()));
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

  _deleteInFormDialog(BuildContext context, categoryId) {
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
                  var inresult =
                      await _incategoryService.deleteCategory(categoryId);
                  if (inresult > 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen()));
                    getAllInCategories();
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

  _deleteExFormDialog(BuildContext context, categoryId) {
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
                  var exresult =
                      await _excategoryService.deleteCategory(categoryId);
                  if (exresult > 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen()));
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => HomeScreen()));
                    getAllExCategories();
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
            decoration: new BoxDecoration(color: Colors.black),
            child: new TabBar(
              controller: _controller,
              tabs: [
                new Tab(
                  icon: const Icon(Icons.paid_rounded),
                  text: 'Income',
                ),
                new Tab(
                  icon: const Icon(Icons.price_change_rounded),
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
                    itemCount: _incategoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                        child: Card(
                          elevation: 6.0,
                          shadowColor: Colors.black26,
                          child: ListTile(
                            leading: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editInCategory(
                                      context, _incategoryList[index].id);
                                }),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(_incategoryList[index].inname),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _deleteInFormDialog(
                                          context, _incategoryList[index].id);
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                new ListView.builder(
                    itemCount: _excategoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                        child: Card(
                          elevation: 6.0,
                          shadowColor: Colors.black26,
                          child: ListTile(
                            leading: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editExCategory(
                                      context, _excategoryList[index].id);
                                }),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(_excategoryList[index].exname),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _deleteExFormDialog(
                                          context, _excategoryList[index].id);
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
          if (_controller.index == 0) {
            print('index 0');
            _showInFormDialog(context);
          } else {
            print('index 1');
            _showExFormDialog(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
