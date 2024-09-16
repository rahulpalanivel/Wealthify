import 'package:app/view/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _selectedIndex,
      child: Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          title: const Text('Welcome Rahul'),
        ),
      ),
    );
  }
}
