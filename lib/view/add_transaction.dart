import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyist/Consanants/consanants.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _type;
  String _amount;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd,yyyy');

  final List<String> _types = ['Income', 'Expense'];

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title ${_dateFormatter.format(_date)} $_type $_amount');
      Navigator.pushNamed(context, '/home');
    }
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  // List<bool> isSelected;
  // String _chosenValue;

  @override
  void initState() {
    // isSelected = [true, false];
    super.initState();
    print('${DateTime.now()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Add Transactions',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Memo',
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please Enter a Memo Keyword'
                            : null,
                        onSaved: (input) => _title = input,
                        initialValue: _title,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (input) =>
                            _amount == null ? 'Please Enter a amount' : null,
                        onSaved: (input) => _amount = input,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _dateController,
                        onTap: _handleDatePicker,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please Select a Date'
                            : null,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      DropdownButtonFormField(
                        isDense: true,
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 22,
                        iconEnabledColor: Colors.redAccent,
                        items: _types.map((String type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          );
                        }).toList(),
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Type',
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (input) =>
                            _type == null ? 'Please Select a Money Type' : null,
                        onChanged: (value) {
                          setState(() {
                            _type = value;
                          });
                        },
                        value: _type,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  // ToggleButtons(
                  //   borderColor: Colors.grey,
                  //   fillColor: Colors.blueAccent,
                  //   borderWidth: 0,
                  //   selectedBorderColor: Colors.black,
                  //   selectedColor: Colors.white,
                  //   borderRadius: BorderRadius.circular(8),
                  //   children: const <Widget>[
                  //     Padding(
                  //       padding:
                  //           EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  //       child: Text(
                  //         'Income',
                  //         style: TextStyle(
                  //             fontSize: 16, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding:
                  //           EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  //       child: Text(
                  //         'Expense',
                  //         style: TextStyle(
                  //             fontSize: 16, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ],
                  //   onPressed: (int index) {
                  //     setState(() {
                  //       for (int i = 0; i < isSelected.length; i++) {
                  //         isSelected[i] = i == index;
                  //       }
                  //     });
                  //   },
                  //   isSelected: isSelected,
                  // ),

                  //TODO: add dropdown button
                  RaisedButton.icon(
                    onPressed: () {},
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    label: Text('Add a Photo'),
                    icon: Icon(Icons.camera),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      _submit();
                    },
                    color: Color(0xFF1A2E35),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    label: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
