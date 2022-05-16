import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/presentation/pages/login_page.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/welcome.png"),
            SizedBox(height: SizeConfig.screenHeight! * 0.05,),
            Container(
              width: SizeConfig.screenWidth! * 0.8,
              child: Text(
                "Chào mừng bạn đến với app quản lý y tế Phú Quốc!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.screenWidth! * 0.05
                ),  
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.08,),
            BigButton(title: "BẮT ĐẦU NGAY", ontap: (){
              prefs!.setBool("FIRST_OPEN", false);
              changePageWithReplacement(context, LoginPage());
            },)
          ],
        ),
      ),
    );
  }
}
