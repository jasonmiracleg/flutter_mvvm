import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view/pages/pages.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[HomePage(), CostPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBack(
        waitForSecondBackPress: 4,
        onFirstBackPress: (context) {
          return Fluttertoast.showToast(
              msg: "Press back again to close app!",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 14);
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Cost Info')
        ],
      ),
    );
  }
}