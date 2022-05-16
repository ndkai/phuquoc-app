import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/home_page/presentation/pages/home_page.dart';
import 'package:phuquoc/feature/notify_page/presentation/pages/notify_page.dart';
import 'package:phuquoc/feature/user/presentation/pages/user_page.dart';
import 'custom_bar.dart';
class MyBottomBar extends StatefulWidget {
  final BuildContext? menuScreenContext;
  MyBottomBar({Key? key, this.menuScreenContext}) : super(key: key);

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  PersistentTabController? _controller;
  bool? _hideNavBar = false;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(appContext: context,),
      // NotifyPage(),
      NotifyPage(),
      UserPage(appContext: context,)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon:  Image.asset("assets/icons/bottom_bar/home.png", color: _controller!.index == 0 ? Colors.blueAccent:Colors.black, width: SizeConfig.screenWidth! * 0.06),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      // PersistentBottomNavBarItem(
      //   icon:  Image.asset("assets/icons/bottom_bar/datlich.png", color: _controller!.index == 1 ? Colors.blueAccent:Colors.black, width: SizeConfig.screenWidth! * 0.06),
      //   title: ("Đặt lịch"),
      //   activeColorPrimary: Colors.blue,
      //   inactiveColorPrimary: Colors.grey,
      // ),
      PersistentBottomNavBarItem(
        icon:  Image.asset("assets/icons/bottom_bar/thongbao.png", color: _controller!.index == 2 ? Colors.blueAccent:Colors.black, width: SizeConfig.screenWidth! * 0.06),
        title: ("Thông báo"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),                          
      PersistentBottomNavBarItem(
        icon:  Image.asset("assets/icons/bottom_bar/taikhoan.png", color: _controller!.index == 3 ? Colors.blueAccent:Colors.black,width: SizeConfig.screenWidth! * 0.06),
        title: ("Tài khoản"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView.custom(
        context,
        controller: _controller,
        screens: _buildScreens(),
        confineInSafeArea: true,
        itemCount: 3,
        handleAndroidBackButtonPress: true,
        stateManagement: true,
        hideNavigationBar: _hideNavBar,
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        customWidget: CustomNavBarWidget(
          items: _navBarsItems(),
          onItemSelected: (index) {
            setState(() {
              _controller!.index = index; 
            });
          },
          selectedIndex: _controller!.index,
        ),
      ),
    );
  }
}
