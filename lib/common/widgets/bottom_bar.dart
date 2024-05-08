import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_generator/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userCartLen = context.watch<UserProvider>().user.username.length;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
// borderRadius: BorderRadius.all(Radius.circular(25))
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: height * 0.025, left: width * 0.05, right: width * 0.05),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: BottomNavigationBar(
            currentIndex: _page,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: GlobalVariables.selectedNavBarColor,
            unselectedItemColor: GlobalVariables.unselectedNavBarColor,
            backgroundColor: GlobalVariables.navbarBackgroundColor,
            iconSize: 28,
            onTap: updatePage,
            items: [
              // HOME
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: FaIcon(
                      FontAwesomeIcons.calendar,
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.textTheme,
                    ),
                  ),
                ),
                label: '',
              ),

              BottomNavigationBarItem(
                icon: Container(
                  alignment: Alignment.center,
                  width: bottomBarWidth,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: FaIcon(
                      FontAwesomeIcons.leaf,
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.textTheme,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  alignment: Alignment.center,
                  width: bottomBarWidth,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.textTheme,
                    ),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
