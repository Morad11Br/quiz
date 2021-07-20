import 'package:flutter/material.dart';
import 'package:quiz_app/screens/category-screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome To Quiz",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              width: double.infinity,
              child: Image.asset(
                "assets/back_ground.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      color: Colors.amber,
                      height: MediaQuery.of(context).size.height * 1 / 4,
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Image.asset(
                        "assets/random2.jpg",
                        fit: BoxFit.cover,
                      )),
                  Text(
                    "Quiz App",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      height: MediaQuery.of(context).size.height * 1 / 9,
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Center(
                          child: Text(
                        "Start Quiz",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
