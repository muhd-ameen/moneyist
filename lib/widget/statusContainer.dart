import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyist/screens/nav/home.dart';
import 'package:moneyist/widget/title_head.dart';

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

var totalIncome = 500;
var totalExpense = 100;
var balance = totalIncome - totalExpense;


class _StatusContainerState extends State<StatusContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      decoration: BoxDecoration(
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
                money: totalIncome,
              ),
              SizedBox(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 1),
                ),
              ),
              TitleHead(
                Title: 'Expenses',
                money: totalExpense,
              ),
              SizedBox(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 1),
                ),
              ),
              TitleHead(
                Title: 'Balance',
                money: balance,
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
