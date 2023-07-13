import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

import '../../constants/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List <Widget> pages =[
    const MainFoodPage(),
    Container(child: Center(child: BigText(text: 'History'),),),
    Container(child: Center(child: BigText(text: 'Cart'),),),
    Container(child: Center(child: BigText(text: 'Profile'),),),

  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(size: 30,),
        iconSize: Dimensions.iconSize24,
        unselectedItemColor: AppColors.paraColor,
        selectedItemColor: AppColors.mainColor,
        // showSelectedLabels: false,
        showUnselectedLabels: false,
        // selectedFontSize: 0,
        unselectedFontSize: 0 ,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items:  const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ]
      ),
    );
  }

}
