import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/base_page.dart';
import 'package:phuquoc/feature/base/my_widget/display/infor_field.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({Key? key}) : super(key: key);

  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
        title: "Cài đặt tài khoản",
      onBack: (){
          Navigator.of(context).pop();
      },
      child: Container(
        height: SizeConfig.screenHeight! * 0.91,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight!  * 0.05,),
             infoField("Số điện thoại", "0946706143"),
             infoField("Mật khẩu", "0946706143"),
             infoField("Facebook", "0946706143"),
             infoField("Google", "0946706143"),
          ],
        ),
      ),
    );
  }
}
