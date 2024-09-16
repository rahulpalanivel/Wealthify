// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Your Transactions",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 27,
                    color: const Color.fromARGB(255, 27, 118, 192),
                  ),
                ),
                CCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
