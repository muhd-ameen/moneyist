import 'package:flutter/material.dart';
import 'package:moneyist/models/transaction.dart';
import 'package:moneyist/services/category_service.dart';
import 'package:moneyist/services/transaction_service.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();

  var _todoDescriptionController = TextEditingController();

  var _todoDateController = TextEditingController();

  var _selectedValue;

  var _categories = List<DropdownMenuItem>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _todoDateController.text = DateFormat('dd-MMM-yyyy').format(_dateTime);
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                maxLength: 10,
                controller: _todoTitleController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter a Title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Title', hintText: 'Write a Title'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter a Amount';
                  }
                  return null;
                },
                maxLength: 6,
                controller: _todoDescriptionController,
                decoration:
                    InputDecoration(labelText: 'Amount', hintText: 'Amount'),
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
                items: _categories,
                hint: Text('Category'),
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
              RaisedButton(
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
                      _showSuccessSnackBar(Text('Created'));
                    }
                    print(result);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                },
                color: Colors.blue,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
