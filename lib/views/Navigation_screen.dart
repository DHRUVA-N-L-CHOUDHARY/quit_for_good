// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/views/Choose_type.dart';
import 'package:quit_for_good/views/Profile_screen.dart';
import 'package:quit_for_good/views/homepage/screen/home.dart';

class NavigationScreen extends StatefulWidget {
  late int tabIndex;
  NavigationScreen({super.key, this.tabIndex = 2});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  void changeTabIndex(int index) {
    setState(() {
      widget.tabIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: widget.tabIndex,
          children: [
            const ChooseTypeScreen(),
            HomeScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kPrimaryColor)),
        ),
        height: 80,
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: kPrimaryColor,
          onTap: changeTabIndex,
          iconSize: 16.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.tabIndex,
          items: [
            _bottomNavigationBarItem(
              icon: donate,
              selected: widget.tabIndex == 0 ? true : false,
              label: "Donate",
            ),
            _bottomNavigationBarItem(
              icon: community,
              selected: widget.tabIndex == 1 ? true : false,
              label: "Community",
            ),
            _bottomNavigationBarItem(
              selected: widget.tabIndex == 2 ? true : false,
              icon: profile,
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  _bottomNavigationBarItem(
      {required String icon, required String label, required bool selected}) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        scale: 1.7,
        height: 28,
        color: kPrimaryColor,
      ),
      activeIcon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(icon, scale: 1, height: 30, color: kContrColor),
          )),
      label: label,
    );
  }
}
