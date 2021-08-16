// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:moneyist/helpers/drawer_navigation.dart';
// import 'package:moneyist/models/transaction.dart';
// import 'package:moneyist/repositories/repository.dart';
// import 'package:moneyist/screens/todo_screen.dart';
// import 'package:moneyist/services/transaction_service.dart';
// import 'package:moneyist/widget/title_head.dart';
//
// class HomeScreenNav extends StatefulWidget {
//   @override
//   _HomeScreenNavState createState() => _HomeScreenNavState();
// }
//
// var totalIncome = 0;
// var totalExpense = 0;
// var balance = 0;
//
// class _HomeScreenNavState extends State<HomeScreenNav> {
//   TodoService _todoService;
//   List<Transaction> _todoList = List<Transaction>();
//   var model = Repository();
//   final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
//   DateTime _date = DateTime.now();
//
//   @override
//   initState() {
//     super.initState();
//     getAllTodos();
//   }
//
//   getAllTodos() async {
//     await _todoList.sort((taskA, taskB) =>
//         taskA.transactionDate.compareTo(taskB.transactionDate));
//     _todoService = TodoService();
//     _todoList = List<Transaction>();
//     var todos = await _todoService.readTodos();
//     todos.forEach((todo) {
//       setState(() {
//         var model = Transaction();
//         model.id = todo['id'];
//         model.title = todo['title'];
//         model.amount = todo['amount'];
//         model.category = todo['category'];
//         model.transactionDate = todo['transactionDate'];
//         _todoList.add(model);
//       });
//     });
//   }
//
//   GestureDetector SingleCard(int index) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8),
//         padding: EdgeInsets.symmetric(vertical: 14),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.0),
//           color: Color(0xFFF5F5F5),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             ClipOval(
//               child: _todoList[index].category == 'Income'
//                   ? Image.asset(
//                       'assets/icons/money.png',
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     )
//                   : Image.asset(
//                       'assets/icons/expense.png',
//                       width: 40,
//                       height: 40,
//                       fit: BoxFit.cover,
//                     ),
//             ),
//             Column(
//               children: [
//                 Text(
//                   _todoList[index].title ?? 'No Title',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       _todoList[index].transactionDate ?? 'No Date',
//                       style: TextStyle(
//                           fontSize: 11,
//                           color: Color(0xFF868686),
//                           fontWeight: FontWeight.w800),
//                     ),
//                     SizedBox(
//                       width: 7,
//                     ),
//                     Text(
//                       '${_todoList[index].category}' ?? 'No Category',
//                       style: TextStyle(
//                           fontSize: 11,
//                           color: Color(0xFF868686),
//                           fontWeight: FontWeight.w800),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Text(
//               _todoList[index].amount ?? '--',
//               style: TextStyle(
//                   color: _todoList[index].category == 'Income'
//                       ? Colors.blue
//                       : Colors.redAccent,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w800),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           'MONEYIST',
//           style: TextStyle(
//             fontWeight: FontWeight.w300,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       drawer: DrawerNavigaton(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14.0),
//                 color: Color(0xFF2E2E61),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TitleHead(
//                         Title: 'Income',
//                         money: totalIncome,
//                       ),
//                       SizedBox(
//                         child: Container(
//                           color: Colors.white,
//                           padding:
//                               EdgeInsets.symmetric(vertical: 25, horizontal: 1),
//                         ),
//                       ),
//                       TitleHead(
//                         Title: 'Expenses',
//                         money: totalExpense,
//                       ),
//                       SizedBox(
//                         child: Container(
//                           color: Colors.white,
//                           padding:
//                               EdgeInsets.symmetric(vertical: 25, horizontal: 1),
//                         ),
//                       ),
//                       TitleHead(
//                         Title: 'Balance',
//                         money: balance,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Text(
//                     '${_dateFormatter.format(_date)}',
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//             LimitedBox(
//               maxHeight: 550,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   physics: ScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: _todoList.length,
//                   itemBuilder: (context, index) {
//                     return SingleCard(index);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
