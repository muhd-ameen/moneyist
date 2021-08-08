// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:moneyist/view/add_transaction.dart';
// import 'package:moneyist/widget//title_head.dart';
// import 'package:share/share.dart';
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   String dropdownValue = 'Jan';
//
//   final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
//   DateTime _date = DateTime.now();
//
//   @override
//   void initState() {
//     super.initState();
//     isSelected = [true, false];
//   }
//
//
//
//   Widget _logCard(Log log) {
//     return
//       GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (_) =>
//                     AddTransaction(updateLogList: _updateLogList(), log: log)));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8),
//         padding: EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.0),
//           color: Color(0xFFF5F5F5),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             CircleAvatar(
//               child: Image.asset('assets/images/expense.png'),
//             ),
//             Column(
//               children: [
//                 Text(
//                   log.title,
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
//                 ),
//                 Text(
//                   '${_dateFormatter.format(log.date)} • ${log.type}',
//                   style: TextStyle(
//                       fontSize: 11,
//                       color: Color(0xFF868686),
//                       fontWeight: FontWeight.w800),
//                 ),
//               ],
//             ),
//             Text(
//               '₹${log.amount}',
//               style: TextStyle(
//                   color: Colors.redAccent,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w800),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<bool> isSelected;
//   String _chosenValue;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => AddTransaction(
//                 updateLogList: _updateLogList,
//               ),
//             ),
//           );
//         },
//         backgroundColor: Color(0xFFFF4F5A),
//       ),
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             _scaffoldKey.currentState.openDrawer();
//           },
//           icon: Icon(Icons.menu),
//           color: Colors.black,
//         ),
//         actions: [
//           DropdownButton<String>(
//             value: dropdownValue,
//             icon: const Icon(Icons.event_outlined),
//             iconSize: 22,
//             elevation: 16,
//             style: const TextStyle(
//                 color: Color(0xFF494949), fontWeight: FontWeight.bold),
//             underline: Container(
//               height: 2,
//               color: Color(0xFF1A2E35),
//             ),
//             onChanged: (String newValue) {
//               setState(() {
//                 dropdownValue = newValue;
//               });
//             },
//             items: <String>[
//               'Jan',
//               'Feb',
//               'Mar',
//               'Apr',
//               'May',
//               'Jun',
//               'Jul',
//               'Aug',
//               'Sep',
//               'Oct',
//               'Nov',
//               'Dec'
//             ].map<DropdownMenuItem<String>>(
//               (String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               },
//             ).toList(),
//           ),
//           SizedBox(
//             width: 15,
//           )
//         ],
//       ),
//       body: FutureBuilder(
//         future: _logList,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//             itemCount: 1 + snapshot.data.length,
//             itemBuilder: (BuildContext context, int index) {
//               if (index == 0) {
//                 return
//                   Column(
//                   children: [
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 30, horizontal: 25),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(14.0),
//                         color: Color(0xFF1A2E35),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               TitleHead(
//                                 Title: 'Income',
//                                 money: income,
//                               ),
//                               SizedBox(
//                                 child: Container(
//                                   color: Colors.white,
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 25, horizontal: 1),
//                                 ),
//                               ),
//                               TitleHead(
//                                 Title: 'Expenses',
//                                 money: expense,
//                               ),
//                               SizedBox(
//                                 child: Container(
//                                   color: Colors.white,
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 25, horizontal: 1),
//                                 ),
//                               ),
//                               TitleHead(
//                                 Title: 'Balance',
//                                 money: balance,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 25,
//                           ),
//                           Text(
//                             '${_dateFormatter.format(_date)}',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     ToggleButtons(
//                       borderColor: Colors.grey,
//                       fillColor: Colors.blueAccent,
//                       borderWidth: 0,
//                       selectedBorderColor: Colors.black,
//                       selectedColor: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       children: const <Widget>[
//                         Padding(
//                           padding:
//                               EdgeInsets.symmetric(vertical: 5, horizontal: 30),
//                           child: Text(
//                             'Income',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Padding(
//                           padding:
//                               EdgeInsets.symmetric(vertical: 5, horizontal: 30),
//                           child: Text(
//                             'Expense',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                       onPressed: (int index) {
//                         setState(() {
//                           for (int i = 0; i < isSelected.length; i++) {
//                             isSelected[i] = i == index;
//                           }
//                         });
//                       },
//                       isSelected: isSelected,
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                   ],
//                 );
//               }
//               return _logCard(snapshot.data[index - 1]);
//             },
//           );
//         },
//       ),
//       drawer: Drawer(
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//               child: DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage("assets/images/drawer.png"),
//                   ),
//                   // color: Colors.teal,
//                 ),
//                 child: null,
//               ),
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.category_outlined,
//                 color: Colors.redAccent,
//               ),
//               title: Text('Manage Category'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/AddCategory');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.get_app_outlined, color: Colors.deepPurple),
//               title: Text('Export Data'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/ExportData');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings_outlined, color: Colors.teal),
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/setting');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.star_outline_outlined, color: Colors.orange),
//               title: Text('Rate Us'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/Rating');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.mobile_screen_share_outlined,
//                   color: Colors.blueAccent),
//               title: Text('Share App'),
//               onTap: () {
//                 Share.share(
//                     'check out The Moneyist website https://example.com',
//                     subject: 'Look what I made!');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.info_outlined, color: Colors.deepPurple),
//               title: Text('About Us'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/Support');
//               },
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Column(
//               children: [
//                 Text('V 0.01'),
//                 IconButton(
//                   icon: Icon(Icons.integration_instructions_outlined),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
