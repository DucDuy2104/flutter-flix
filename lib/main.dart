import 'package:flutter/material.dart';
import 'package:flutter_flix/pages/movie_detail.dart';
import 'package:flutter_flix/utils//app_colors.dart';
import 'package:flutter_flix/pages/home_page.dart';
import 'package:flutter_flix/pages/search_page.dart';
import 'package:flutter_flix/pages/watch_list.dart';
import 'package:flutter_flix/utils/app_size.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: BottomNav()),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BottomNav();
  }
}

class _BottomNav extends State<BottomNav> {
  int _currentIndex = 0;
  final List<Widget> _list = [
    const HomePage(),
    const SearchPage(),
    const WatchListPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list[_currentIndex],
      bottomNavigationBar: Container(
        height: 78,
        width: double.infinity,
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(width: 1, color: Color(0xFF0296E5)))),
        child: BottomNavigationBar(
            backgroundColor: darkBg,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            unselectedItemColor: const Color(0xFF67686D),
            selectedItemColor: const Color(0xFF0296E5),
            unselectedLabelStyle: const TextStyle(
                height: 2.5, fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12),
            selectedLabelStyle: const TextStyle(
                height: 2.5, fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12),
            items: [
              BottomNavigationBarItem(
                  icon: _currentIndex == 0
                      ? Image.asset("assets/images/home_ch.png",
                          width: iconSize, height: iconSize, fit: BoxFit.cover)
                      : Image.asset("assets/images/home.png",
                          width: iconSize, height: iconSize, fit: BoxFit.cover),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: _currentIndex == 1
                      ? Image.asset("assets/images/search_ch.png",
                          width: iconSize, height: iconSize, fit: BoxFit.cover)
                      : Image.asset("assets/images/search.png",
                          width: iconSize, height: iconSize, fit: BoxFit.cover),
                  label: "Search"),
              BottomNavigationBarItem(
                  icon: _currentIndex == 2
                      ? Image.asset("assets/images/mark_ch.png",
                          width: iconSize, height: iconSize, fit: BoxFit.cover)
                      : Image.asset("assets/images/mark.png",
                          width: iconSize, height: iconSize, fit: BoxFit.cover),
                  label: "Watch List"),
            ]),
      ),
    );
  }
}
