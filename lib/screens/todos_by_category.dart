import 'package:flutter/material.dart';
import 'package:moneyist/models/transaction.dart';
import 'package:moneyist/services/transaction_service.dart';

class TodosByCategory extends StatefulWidget {
  final String category;

  TodosByCategory({this.category});

  @override
  _TodosByCategoryState createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Transaction> _todoList = List<Transaction>();
  TodoService _todoService = TodoService();

  @override
  void initState() {
    super.initState();
    getTodosByCategories();
  }

  getTodosByCategories() async {
    var todos = await _todoService.readTodosByCategory(this.widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Transaction();
        model.title = todo['title'];
        model.amount = todo['amount'];
        model.transactionDate = todo['transactionDate'];

        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.category)),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
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
                              child: Image.asset('assets/images/expense.png'),
                            ),
                            Column(
                              children: [
                                Text(
                                  _todoList[index].title ?? 'No Title',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  _todoList[index].transactionDate ?? 'No Date',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF868686),
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            Text(
                              _todoList[index].amount ?? 'No Category',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
