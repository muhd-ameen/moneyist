import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyist/helpers/drawer_navigation.dart';
import 'package:moneyist/models/transaction.dart';
import 'package:moneyist/repositories/repository.dart';
import 'package:moneyist/screens/todo_screen.dart';
import 'package:moneyist/services/transaction_service.dart';
import 'package:moneyist/widget/title_head.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;
  List<Transaction> _todoList = List<Transaction>();
  var model = Repository();

  @override
  initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = List<Transaction>();
    _todoList.sort((taskA, taskB) =>
        taskB.transactionDate.compareTo(taskA.transactionDate));
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

  GestureDetector SingleCard(int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Color(0xFFECECEC),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              child: _todoList[index].category == 'Income'
                  ? Image.asset('assets/images/income.png')
                  : Image.asset('assets/images/expense.png'),
            ),
            Column(
              children: [
                Text(
                  _todoList[index].title ?? 'No Title',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                Row(
                  children: [
                    Text(
                      _todoList[index].transactionDate ?? 'No Date',
                      style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF868686),
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      '${_todoList[index].category}' ?? 'No Category',
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
              _todoList[index].amount ?? 'No Category',
              style: TextStyle(
                  color: _todoList[index].category == 'Income'
                      ? Colors.blue
                      : Colors.redAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'MONEYIST',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      drawer: DrawerNavigaton(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: _todoList.length,
            itemBuilder: (context, index) {
              return SingleCard(index);
            }),
      ),
    );
  }
}
