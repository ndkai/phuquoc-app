import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/presentation/pages/login_page.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        onLogOutPressed(context);
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.exit_to_app,
                size: SizeConfig.screenWidth! * 0.05,
              ),
            ),
            Center(
              child: Text("Đăng Xuất",
                  style: TextStyle(color: Colors.red, fontSize: SizeConfig.screenWidth! * 0.04)),
            )
          ],
        ),

      ),
    );
  }
  Future<void> onLogOutPressed(BuildContext context) async {
    prefs!.clear();
    pushDynamicScreen(
      context,
      screen: LoginPage(),
      withNavBar: true,
    );
  }
}
