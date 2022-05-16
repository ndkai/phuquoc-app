import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/my_texts.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_button.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_password_field.dart';
import 'package:phuquoc/feature/base/base_page.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseSubPage(
      title: "Đổi Mật Khẩu",
      onBack: () {},
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight! * 0.1,
          ),
          Text(
            "Vui Lòng Đặt Lại Mật Khẩu Mới",
            style: bigBoldTextStyle,
          ),
          Text(
            "Tạo mật khẩu mới không trùng với 3 mật khẩu gần đây nhất",
            style: normalFadeTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.05,
          ),
          RoundedPasswordField(
            width: SizeConfig.screenWidth,
            title: "Mật khẩu mới",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            title: "Nhập lại mật khẩu mới",
            width: SizeConfig.screenWidth,
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "Cập Nhật",
            color: Colors.blue,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
