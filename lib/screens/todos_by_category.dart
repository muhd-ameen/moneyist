import 'package:flutter/material.dart';
import 'package:moneyist/models/transaction.dart';
import 'package:moneyist/screens/home_screen.dart';
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

    todos.forEach((todo) async {
      var parseData = await int.parse(todo['amount'].toString()) ?? 'No amount';
      setState(() {
        var model = Transaction();
        model.title = todo['title'];
        model.amount = parseData as int;
        model.category = todo['category'];
        model.transactionDate = todo['transactionDate'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          this.widget.category,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  if (_todoList.length == null) {
                    Center(
                      child: Image.asset("assets/images/navimg.jpg"),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    padding: EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Color(0xFFF5F5F5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  fontSize: 15, fontWeight: FontWeight.w800),
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
                          _todoList[index].amount.toString() ?? 'No Category',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
