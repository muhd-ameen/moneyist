import 'package:flutter/material.dart';
import 'package:moneyist/Consanants/consanants.dart';

class AddTransaction extends StatefulWidget {

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
   List<bool> isSelected;

   String _chosenValue;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'Add Transactions',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4F4F4F)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'Memo'))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4F4F4F)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'Amount'))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ToggleButtons(
                  borderColor: Colors.grey,
                  fillColor: Colors.blueAccent,
                  borderWidth: 0,
                  selectedBorderColor: Colors.black,
                  selectedColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Text(
                        'Income',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Text(
                        'Expense',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    });
                  },
                  isSelected: isSelected,
                ),
                SizedBox(
                  height: 30,
                ),
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
                  onPressed: () {},
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
    );
  }
}
