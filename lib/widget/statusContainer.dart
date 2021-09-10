import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyist/widget/title_head.dart';
import 'package:shared_preferences/shared_preferences.dart';

var totalIncome = 0;
var totalExpense = 0;
var balance = 0;

class StatusContainer extends StatefulWidget {
  const StatusContainer({
    Key key,
    @required DateFormat dateFormatter,
    @required DateTime date,
  })  : _dateFormatter = dateFormatter,
        _date = date,
        super(key: key);

  final DateFormat _dateFormatter;
  final DateTime _date;

  @override
  _StatusContainerState createState() => _StatusContainerState();
}

class _StatusContainerState extends State<StatusContainer> {

  @override
  void initState() {
    super.initState();
    getIncome();
  }
var totalIncomes;
  getIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    totalIncomes = prefs.getInt('totalIncome');
    print('Total Income : $totalIncome');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/containerbg.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(14.0),
        color: Color(0xFF2E2E61),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleHead(
                Title: 'Income',
                money: totalIncome == null ? 1 : totalIncome,
              ),
              SizedBox(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 1),
                ),
              ),
              TitleHead(
                Title: 'Expenses',
                money: totalExpense == null ? 1 : totalExpense,
              ),
              SizedBox(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 1),
                ),
              ),
              TitleHead(
                Title: 'Balance',
                money: balance == null ? 1 : balance,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            '${widget._dateFormatter.format(widget._date)}',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
          )
        ],
      ),
    );
  }
}
