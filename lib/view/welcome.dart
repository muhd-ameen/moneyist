import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/welcome.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              'SAVE YOUR MONEY',
              style: TextStyle(
                color: Color(0xFF313030),
                fontWeight: FontWeight.w900,
                fontSize: 21,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Best Solution to save and invest our money just with smartphone',
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 2,
                color: Color(0xFF9B9B9B),
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: Color(0xFF1A2E35),
                child: Text(
                  '  Get Started  ',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
