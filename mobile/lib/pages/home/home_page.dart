import 'package:flutter/material.dart';
import 'package:food_express/controller/popular_product_controller.dart';
import 'package:food_express/pages/account/account_page.dart';
import 'package:food_express/pages/cart/my_orders_page.dart';
import 'package:food_express/pages/home/main_food_page.dart';
import 'package:food_express/pages/notification/notification_page.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.selectedIndex});

  int selectedIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = const [
    MainFoodPage(),
    MyOrders(),
    NotificationPage(),
    AccountPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[widget.selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: widget.selectedIndex,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: onTapNav,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 26),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "User",
            )
          ],
        ),
      ),
    );
  }
}
