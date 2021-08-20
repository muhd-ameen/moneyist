import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneyist/helpers/image_helper.dart';
import 'package:moneyist/models/transaction.dart';
import 'package:moneyist/services/Income_category_service.dart';
import 'package:moneyist/services/expense_category_service.dart';
import 'package:moneyist/services/transaction_service.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';
import '../test/Home.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();
  var _todoDateController = TextEditingController();

  var _selectedValue;
  var _transaction = Transaction();

  var _incategories = List<DropdownMenuItem>();
  var _excategories = List<DropdownMenuItem>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _todoDateController.text = DateFormat('dd-MMM-yyyy').format(_dateTime);
    _loadCategories();
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

  DateTime _dateTime = DateTime.now();

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

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  String _selectedCategory = 'income';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Add Transaction',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFFF5F5F5),
            ),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    maxLength: 15,
                    autofocus: true,
                    controller: _todoTitleController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please Enter a Memo';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Memo', hintText: 'Write a Memo'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please Enter a Amount';
                      }
                      return null;
                    },
                    maxLength: 6,
                    controller: _todoDescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: 'Amount',
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _todoDateController,
                    onTap: () {
                      _selectedTodoDate(context);
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please Select a Date';
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
                  ListTile(
                    leading: Radio(
                      value: 'income',
                      groupValue: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    title: Text('Income'),
                  ),
                  ListTile(
                    leading: Radio(
                      value: 'expense',
                      groupValue: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    title: Text('Expense'),
                  ),
                  _selectedCategory == 'income'
                      ? DropdownButtonFormField(
                          value: _selectedValue,
                          items: _incategories,
                          hint: Text('Income Categories'),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please Select a Category';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        )
                      : DropdownButtonFormField(
                          value: _selectedValue,
                          items: _excategories,
                          hint: Text('Expense Categories'),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
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
                    height: 20,
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
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: RaisedButton.icon(
                      icon: Icon(
                        Icons.done_all_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Save Transaction',
                        style: TextStyle(color: Colors.white),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          var todoObject = Transaction();

                          todoObject.title = _todoTitleController.text;
                          todoObject.amount = _todoDescriptionController.text;
                          todoObject.category = _selectedValue.toString();
                          todoObject.transactionDate = _todoDateController.text;

                          var _todoService = TodoService();
                          var result = await _todoService.saveTodo(todoObject);

                          if (result > 0) {
                            _showSuccessSnackBar(
                              Text('Created'),
                            );
                          }
                          print(result);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                        }
                      },
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
