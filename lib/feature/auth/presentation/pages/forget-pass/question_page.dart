import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/constant/my_colors.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/data/models/forgot-pass-response.dart';
import 'package:phuquoc/feature/auth/data/models/question_swagger.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:phuquoc/feature/auth/presentation/pages/change_page_page.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_input_field.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';

import '../../../../../injection_container.dart';
import 'package:http/http.dart' as http;

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late BuildContext currentContext;
  late String answer;
  late String username;
  late QuestionSwagger questionSwagger;
  late Future<ForgotPaswordAuth> authentication;
  String quesTitle = "Vui lòng chọn câu hỏi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            print("AuthState $state");
            if (state is AuthLoading) {
              showLoadingDialog(context);
            } else if (state is GetSQLoaded) {
              Navigator.of(context).pop();
              setState(() {
                questionSwagger = state.questionSwagger;
              });
              // changePage(context, EmailOtpPage(emal: email,));
            } else if (state is AuthError) {
              Navigator.of(context).pop();
              showToastString("${state.msg}");
            }
          },
          builder: (context, state) {
            currentContext = context;
            if (state is AuthInitial) {
              BlocProvider.of<AuthBloc>(currentContext).add(LoadingE());
              BlocProvider.of<AuthBloc>(currentContext).add(GetSQE());
            }
            return Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: Stack(
                children: [
                  Container(
                    height: SizeConfig.screenHeight! * 0.35,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/bgs/login_header.png"),
                            fit: BoxFit.scaleDown)),
                    child: Center(
                      child: Text(
                        "Vui lòng chọn câu hỏi",
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth! * 0.08,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.29,
                      ),
                      Center(
                        child: Container(
                          width: SizeConfig.screenWidth! * 0.8,
                          child: Text(
                            "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeConfig.screenWidth! * 0.04,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                          width: SizeConfig.screenWidth! * 0.9,
                          height: SizeConfig.screenHeight! * 0.08,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          // width: size.width * 0.8,
                          decoration: BoxDecoration(
                            // color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: kActiveShadowColor,
                                offset: Offset(3, 3),
                              ),
                              BoxShadow(
                                color: kActiveShadowColor,
                                offset: Offset(-3, 3),
                              ),
                              BoxShadow(
                                color: kActiveShadowColor,
                                offset: Offset(-2, -2),
                              )
                            ],
                            // border: Border.all(color: Colors.grey, width: 1)
                          ),
                          child: InkWell(
                            onTap: () {
                              showQuesDialog();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$quesTitle",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.045),
                                ),
                                Icon(Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.02,
                      ),
                      RoundedInputField(
                        width: SizeConfig.screenWidth! * 0.9,
                        icon: Icons.question_answer_outlined,
                        hintText: "Nhập câu trả lời của bạn",
                        onChanged: (value) {
                          answer = value;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.02,
                      ),
                      RoundedInputField(
                        width: SizeConfig.screenWidth! * 0.9,
                        icon: Icons.phone_iphone,
                        hintText: "Số điện thoại đăng nhập",
                        onChanged: (value) {
                          username = value;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.05,
                      ),
                      BigButton(
                        title: "XÁC NHẬN",
                        ontap: () {
                          moveToChangePasswordPage(context);
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Hủy bỏ'))
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void showQuesDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Center(
            child: Text('Chọn câu hỏi bảo mật'),
          ),
          content: Container(
            height: SizeConfig.screenHeight! * 0.5,
            width: SizeConfig.screenWidth,
            child: ListView(children: buildQuestion(questionSwagger)),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text('Hủy bỏ'))
          ],
        );
      },
    );
  }

  List<Widget> buildQuestion(QuestionSwagger swagger) {
    return swagger.data!
        .map((e) => quesItem("${e.question.toString()}"))
        .toList();
  }

  Widget quesItem(String ques) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
          quesTitle = ques;
        });
      },
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight! * 0.03),
        margin: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: SizeConfig.screenWidth! * 0.02,
              width: SizeConfig.screenWidth! * 0.02,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1)),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: SizeConfig.screenWidth! * 0.5,
              child: Text(
                "$ques",
                style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.045),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<ForgotPaswordAuth?> requestConfirmSecurityQuestion() async {
    final response = await http.post(Uri.parse(
        'https://chis-api.bakco.vn/v1/auth/Users/ResetPassword/ConfirmSecurityQuestion'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var auth = ForgotPaswordAuth.fromJson(jsonDecode(response.body));
      return auth;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // throw Exception('Failed to load album');
      return null;
    }
  }

  void moveToChangePasswordPage(BuildContext context) {
    var auth = requestConfirmSecurityQuestion();
    // ignore: unnecessary_null_comparison
    if (auth != null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ChangePassPage()));
    } else {
      showToastString("Fail");
    }
  }
}
