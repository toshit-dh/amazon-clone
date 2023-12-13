import 'package:flutter/material.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:amazoncloneapp/features/admin/screens/admin_analytics.dart';
import 'package:amazoncloneapp/features/admin/screens/orders_screen.dart';
import 'package:amazoncloneapp/features/admin/screens/posts_screens.dart';


class BottomBarAdmin extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBarAdmin({super.key});
  @override
  State<BottomBarAdmin> createState() => _BottomBarAdminState();
}

class _BottomBarAdminState extends State<BottomBarAdmin> {
  int _page = 0;
  double width = 42;
  double borderwidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticScreen(),
    const OrdersScreenAdmin(),
  ];

  void setPage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: setPage,
        currentIndex: _page,
        selectedItemColor: Globals.selectedNavBarColor,
        unselectedItemColor: Globals.unselectedNavBarColor,
        backgroundColor: Globals.backgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: width,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? Globals.selectedNavBarColor
                                : Globals.backgroundColor,
                            width: borderwidth))),
                child: const Icon(Icons.home_outlined),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                width: width,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 1
                                ? Globals.selectedNavBarColor
                                : Globals.backgroundColor,
                            width: borderwidth))),
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                width: width,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 2
                                ? Globals.selectedNavBarColor
                                : Globals.backgroundColor,
                            width: borderwidth))),
                child: const Icon(Icons.all_inbox_outlined),
              ),
              label: ""),
        ],
      ),
    );
  }
}
