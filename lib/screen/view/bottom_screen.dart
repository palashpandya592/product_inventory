import 'package:flutter/material.dart';
import 'package:product_app/constant/app_assets.dart';
import 'package:product_app/constant/app_colors.dart';
import 'package:product_app/main.dart';
import 'package:product_app/screen/home/home_screen.dart';
import 'package:product_app/screen/profile/profile_screen.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  List<Widget> widgetList = <Widget>[HomeScreen(), ProfileScreen()];

  void onPageChangedIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: false,
      body: widgetList.elementAt(pageIndex),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  offset: Offset(0.0, 1.0),
                  blurRadius: 8.0)
            ],
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: AppColors.secondary,
          selectedItemColor: AppColors.primary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: pageIndex,
          onTap: (int index) {
            onPageChangedIndex(index);
          },
          items: [
            navigationBarItem(index: 0, pngIcon: Assets.homeIcon),
            navigationBarItem(index: 1, pngIcon: Assets.profileIcon),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem navigationBarItem(
      {required int index, required String pngIcon}) {
    return BottomNavigationBarItem(
        icon: Column(
          children: [
            Image.asset(pngIcon,
                height: 25,
                width: 25,
                fit: BoxFit.cover,
                color: index == pageIndex
                    ? AppColors.primary
                    : AppColors.secondary),
            SizedBox(height: 5),
            Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == pageIndex
                        ? AppColors.primary
                        : Colors.transparent))
          ],
        ),
        label: '');
  }
}
