import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/presentation/pages/forget-pass/email_page.dart';
import 'package:phuquoc/feature/auth/presentation/pages/forget-pass/question_page.dart';
import 'package:phuquoc/feature/auth/presentation/pages/forget-pass/sms-page.dart';
import 'package:phuquoc/feature/base/base_page.dart';

class ForgetPassMethodPage extends StatefulWidget {
  const ForgetPassMethodPage({Key? key}) : super(key: key);

  @override
  _ForgetPassMethodPageState createState() => _ForgetPassMethodPageState();
}

class _ForgetPassMethodPageState extends State<ForgetPassMethodPage> {
  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title: "",
      onBack: (){
        Navigator.of(context).pop();
      },                                                                                                             
      child: Container(
        height: SizeConfig.screenHeight! * 0.91,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight! * 0.03,),
            Container(
              width: SizeConfig.screenWidth! * 0.8,
              child: Text("Vui lòng chọn phương thức lấy lại mật khẩu",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400, fontSize: SizeConfig.screenWidth! * 0.05),),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.03,),
            item('Gửi SMS',"assets/icons/mobile.png", ontap: (){
              changePage(context, SmsPage());
            }),
            item('Gửi Gmail', "assets/icons/Email.png", ontap: (){
              changePage(context, EmailPage());
            }),
            item('Câu hỏi bảo mật', "assets/icons/message-question.png",ontap: (){
              changePage(context, QuestionPage());
            }),
          ],
        ),
      ),
    );
  }

  Widget item(String s, String image, {Function? ontap}){
    return InkWell(
      onTap: (){
        ontap!();
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.03),
        margin: EdgeInsets.all(SizeConfig.screenWidth! * 0.04),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          color: Colors.blue,
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.02)
        ),
        child: Row(
            children: [
              Image.asset(image, width: SizeConfig.screenWidth! * 0.1,),
              Text("    ${s}", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.05, color: Colors.white),),
            ],
        ),
      ),
    );
  }
  
}
