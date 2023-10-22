

import 'package:flutter/material.dart';
import 'package:myfirst_flutter_project/display_screen.dart';
import 'package:myfirst_flutter_project/form_screen.dart';
import 'package:myfirst_flutter_project/home_screen.dart';
import 'package:myfirst_flutter_project/search_screen.dart';

class BottomNavigation extends StatefulWidget {
  static const String id = 'navigation_bar';
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const FormScreen(),
    const SearchScreen(),
    const DisplayData()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,),
        
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Form"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Information')
          ],
        )
        );
      
  }
}