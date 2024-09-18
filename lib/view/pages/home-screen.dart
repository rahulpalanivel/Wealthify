// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/view/widgets/Flow.dart';
import 'package:app/view/widgets/card.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Overview",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: const Color.fromARGB(255, 27, 118, 192),
                    ),
                  ),
                ),
              ),
              Center(child: CCard()),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Cash Flow",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: const Color.fromARGB(255, 27, 118, 192),
                    ),
                  ),
                ),
              ),
              Center(child: FLow()),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
