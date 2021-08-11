import 'package:flutter/material.dart';
import 'package:moneyist/screens/home_screen.dart';

class ExportData extends StatefulWidget {
  @override
  _ExportDataState createState() => _ExportDataState();
}

class _ExportDataState extends State<ExportData> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime currentDate = DateTime.now();
  DateTime currentDate1 = DateTime.now();

  Future<void> _startDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate1,
        firstDate: DateTime(2021),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != currentDate1)
      setState(() {
        currentDate1 = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        centerTitle: true,
        title: Text(
          'Export Data',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Image.asset('assets/images/export.png')),
              ),
              Text(
                'Select A Duration to Export Data',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton.icon(
                    onPressed: () => _startDate(context),
                    color: Color(0xFF3C354C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    label: Text(
                      'Start Date',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.date_range_outlined,
                      color: Colors.white,
                    ),
                  ),
                  RaisedButton.icon(
                    onPressed: () => _endDate(context),
                    color: Color(0xFF3C354C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    label: Text(
                      'End Date',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.date_range_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: RaisedButton.icon(
                  onPressed: () {
                    _scaffoldKey.currentState.showSnackBar(
                      new SnackBar(
                        duration: Duration(seconds: 2),
                        content: new Text(
                          'Downloaded Successfully',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    );
                  },
                  color: Color(0xFFFF4F5A),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  label: Text(
                    'Export',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(
                    Icons.import_export,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
