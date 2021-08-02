import 'package:flutter/material.dart';

class EditTransaction extends StatefulWidget {

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Edit Transaction',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: Image.asset('assets/images/welcome.png'),
                      ),
                      Text(
                        'Netflix Upgradation',
                        style: TextStyle(
                            color: Color(0xFF606060),
                            fontSize: 17,
                            fontWeight: FontWeight.w900),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          icon: Icon(Icons.delete_outline))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Color(0xFF606060),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category :',
                            style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            'Expense',
                            style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount :',
                            style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            '789',
                            style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date :',
                            style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            '27-07-2021',
                            style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Image :',
                            style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                          Icon(Icons.image)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            child: const Icon(
                                Icons.drive_file_rename_outline_outlined),
                            onPressed: () {
                              Navigator.pushNamed(context, '/AddTransaction');
                            },
                            backgroundColor: Color(0xFFFF4F5A),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Image.asset('assets/images/edit-transaction.png'),
            )
          ],
        ),
      ),
    );
  }
}
