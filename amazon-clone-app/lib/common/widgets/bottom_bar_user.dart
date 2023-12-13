import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:badges/badges.dart' as badges;
import 'package:amazoncloneapp/features/account/screens/account_screen.dart';
import 'package:amazoncloneapp/features/cart/screens/cart_screen.dart';
import 'package:amazoncloneapp/features/home/screens/home_screen.dart';
import 'package:amazoncloneapp/providers/user_provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double width = 42;
  double borderwidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void setPage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartlen = context.watch<UserProvider>().user.cart.length;
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
                child: const Icon(Icons.person_outlined),
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
                child: badges.Badge(
                  badgeContent: Text(userCartlen.toString()),
                  child: const Icon(Icons.shopping_cart_outlined),
                ), //badge 3.33,33
              ),
              label: ""),
        ],
      ),
    );
  }
}
