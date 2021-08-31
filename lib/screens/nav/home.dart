import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moneyist/helpers/drawer_navigation.dart';
import 'package:moneyist/helpers/image_helper.dart';
import 'package:moneyist/models/transaction.dart';
import 'package:moneyist/repositories/repository.dart';
import 'package:moneyist/screens/home_screen.dart';
import 'package:moneyist/services/Income_category_service.dart';
import 'package:moneyist/services/expense_category_service.dart';
import 'package:moneyist/services/transaction_service.dart';
import 'package:moneyist/widget/statusContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CrudHome extends StatefulWidget {
  @override
  _CrudHomeState createState() => _CrudHomeState();
}

class _CrudHomeState extends State<CrudHome> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var _todoDateController = TextEditingController();
  var _selectedValue;
  var _incategories = List<DropdownMenuItem>();
  var _excategories = List<DropdownMenuItem>();
  final _formKey = GlobalKey<FormState>();
  var _transaction = Transaction();
  var _transactionService = TodoService();
  List<Transaction> _todoList = List<Transaction>();
  var transaction;
  var _editTransactionTitleController = TextEditingController();
  var _editTransactionAmountController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  TodoService _todoService;
  var model = Repository();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  DateTime _date = DateTime.now();
  var _picker;

  @override
  void initState() {
    super.initState();
    getAllTodos();
    _todoDateController.text = DateFormat('dd-MMM-yyyy').format(_dateTime);
    _loadCategories();
    // getIncome();
    // getExpense();
  }

  getIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    totalIncome = prefs.getInt('totalIncome');
    print('Total Income : $totalIncome');
  }

  getExpense() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    totalIncome = prefs.getInt('totalExpense');
    print('Total Expense : $totalExpense');
  }
  // getBalance() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   balance = prefs.getInt('balance');
  //   print('Total balance : $balance');
  // }

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: _dateTime);

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _todoDateController.text =
            DateFormat('dd-MMM-yyyy').format(_pickedDate);
      });
    }
  }

  _loadCategories() async {
    var _incategoryService = IncomeCategoryService();
    var _excategoryService = ExpenseCategoryService();
    var incategories = await _incategoryService.readCategories();
    var excategories = await _excategoryService.readCategories();
    incategories.forEach((category) {
      setState(() {
        _incategories.add(DropdownMenuItem(
          child: Text(category['inname']),
          value: category['inname'],
        ));
      });
    });
    excategories.forEach((category) {
      setState(() {
        _excategories.add(DropdownMenuItem(
          child: Text(category['exname']),
          value: category['exname'],
        ));
      });
    });
  }

  getAllTodos() async {
    // await _todoList.sort((taskA, taskB) =>
    //     taskA.transactionDate.compareTo(taskB.transactionDate));
    _todoService = TodoService();
    _todoList = List<Transaction>();
    var todos = await _todoService.readTodos();
    todos.forEach((todo) {
      setState(() {
        var model = Transaction();
        model.id = todo['id'];
        model.title = todo['title'];
        model.amount = todo['amount'];
        model.category = todo['category'];
        model.transactionDate = todo['transactionDate'];
        _todoList.add(model);
      });
    });
  }

  // ImagePicker _picker = new ImagePicker();

  _editTransaction(BuildContext context, transactionId) async {
    transaction = await _transactionService.readTransactionById(transactionId);
    var parseData = await (transaction[0]['amount'].toString()) ?? 'No amount';
    setState(() {
      _editTransactionTitleController.text =
          transaction[0]['title'] ?? 'No Name';
      _editTransactionAmountController.text = parseData;

      _todoDateController.text = transaction[0]['transactionDate'] ?? 'No date';
      _selectedValue = transaction[0]['category'] ?? 'No categoty';
      _picker = transaction[0]['memoImage'] ?? 'No image';
    });
    _editFormDialog(context);
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
                  if (_formKey.currentState.validate()) {
                    var myInt =
                        int.parse(_editTransactionAmountController.text);
                    assert(myInt is int);
                    print(myInt);
                    _transaction.id = transaction[0]['id'];
                    _transaction.title = _editTransactionTitleController.text;
                    _transaction.amount = myInt;
                    _transaction.transactionDate = _todoDateController.text;
                    _transaction.category = _selectedValue;

                    var result =
                        await _transactionService.updateTodos(_transaction);

                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // var newValue;
                    //
                    // var previousValue = prefs.getInt('totalIncome');
                    //
                    // if (_transaction.amount < previousValue) {
                    //   newValue = myInt - previousValue;
                    //   prefs.setInt(
                    //       'totalIncome', totalIncome - newValue);
                    //   balance = totalIncome - totalExpense;
                    // } else if (_transaction.amount > previousValue) {
                    //   newValue = _transaction.amount - previousValue;
                    //   prefs.setInt(
                    //       'totalIncome', totalIncome + newValue);
                    //   balance = totalIncome - totalExpense;
                    // }

                    if (result > 0) {
                      getAllTodos();
                      showToast('Updated');
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text('Edit Transactions'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter a Title';
                        }
                        return null;
                      },
                      controller: _editTransactionTitleController,
                      decoration: InputDecoration(
                          hintText: 'Write a category', labelText: 'Category'),
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter a Amount';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      maxLength: 6,
                      controller: _editTransactionAmountController,
                      decoration: InputDecoration(
                          labelText: 'Amount', hintText: 'Amount'),
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: _todoDateController,
                      onTap: () {
                        _selectedTodoDate(context);
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter a Title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: 'Pick a Date',
                        prefixIcon: InkWell(
                          // onTap: () {
                          //   _selectedTodoDate(context);
                          // },
                          child: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    DropdownButtonFormField(
                      value: _selectedValue,
                      items: _incategories,
                      hint: Text('Category'),
                      validator: (text) {
                        if (text == null) {
                          return 'Please Select a Category';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormHelper.picPicker(
                      _transaction.memoImage,
                      (file) => {
                        setState(
                          () {
                            _transaction.memoImage = file.path;
                          },
                        )
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, transactionId) {
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
                      await _transactionService.deleteTodos(transactionId);
                  if (result > 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    getAllTodos();
                    showToast('Deleted');
                  }
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
            title: Text('Are you sure you want to delete this?',
                style: TextStyle(fontSize: 16)),
          );
        });
  }

  void showToast(String msg) {
    Toast.show(msg, context, duration: 2, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'MONEYIST',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ),
      drawer: DrawerNavigaton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    getIncome();
                    getExpense();
                  });
                },
                child: StatusContainer(
                    dateFormatter: _dateFormatter, date: _date)),
            LimitedBox(
              maxHeight: 550,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    _todoList.sort((taskA, taskB) =>
                        taskB.transactionDate.compareTo(taskA.transactionDate));
                    return GestureDetector(
                      onTap: () {
                        _editTransaction(context, _todoList[index].id);
                      },
                      onLongPress: () {
                        _deleteFormDialog(context, _todoList[index].id);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Color(0xFFF5F5F5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipOval(
                              child: _todoList[index].category == 'Income'
                                  ? Image.asset(
                                      'assets/icons/money.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/icons/expense.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Column(
                              children: [
                                Text(
                                  _todoList[index].title ?? 'No Title',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _todoList[index].transactionDate ??
                                          'No Date',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF868686),
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '${_todoList[index].category}' ??
                                          'No Category',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF868686),
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              '${_todoList[index].amount}' ?? '--',
                              style: TextStyle(
                                  color: _todoList[index].category != 'Income'
                                      ? Colors.blue
                                      : Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
