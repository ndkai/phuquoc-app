import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/domain/entities/login_request.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:phuquoc/feature/auth/presentation/pages/signup_page.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_input_field.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_password_field.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/home_page/presentation/widgets/bottom_nar.dart';

import '../../../../injection_container.dart';
import 'forget-pass/forget_pass_method.dart';

class LoginPage extends StatefulWidget {
  final bool isLogout;
  const LoginPage({Key? key, this.isLogout = false}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberCheck = false;
  late BuildContext currentContext;
  String? phone;
  String? pass;
  GoogleSignIn? _googleSignIn;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              print("LoginPage ${state}");
              if (state is AuthLoading) {
                showLoadingDialog(context);
              } else if (state is AuthError) {
                Navigator.of(context).pop();
                showToastString("${state.msg}");
              } else if (state is LoginLoaded) {
                Navigator.of(context).pop();
                showToastString("Đăng nhập thành công");
                currentUser = state.loginResponse;
                changePageWithReplacement(
                    context,
                    MyBottomBar(
                      menuScreenContext: context,
                    ));
              } else if (state is AlReadyLogin) {
                Navigator.of(context).pop();
                currentUser = state.loginResponse;
                changePageWithReplacement(
                    context,
                    MyBottomBar(
                      menuScreenContext: context,
                    ));
              }
            },
            builder: (context, state) {
              currentContext = context;
              if (state is AuthInitial) {
                // prefs!.clear();
                if (!widget.isLogout) {
                  BlocProvider.of<AuthBloc>(currentContext).add(LoadingE());
                  BlocProvider.of<AuthBloc>(currentContext).add(CheckLoginE());
                }
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
                          "ĐĂNG NHẬP",
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth! * 0.08,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.29,
                          ),
                          RoundedInputField(
                            width: SizeConfig.screenWidth! * 0.9,
                            icon: Icons.phone_android,
                            hintText: "Nhập số điện thoại",
                            onChanged: (value) {
                              phone = value;
                            },
                          ),
                          RoundedPasswordField(
                            width: SizeConfig.screenWidth! * 0.9,
                            title: "Mật Khẩu",
                            onChanged: (value) {
                              pass = value;
                            },
                          ),
                          // Container(
                          //   width: SizeConfig.screenWidth,
                          //   child:  Align(
                          //     alignment: Alignment.centerRight,
                          //     child: CheckboxListTile(
                          //       title: Text("Nhớ mật khẩu", style: TextStyle(color: Colors.black, fontSize: SizeConfig.screenWidth! * 0.035, fontWeight: FontWeight.bold),),
                          //       value: rememberCheck,
                          //       onChanged: (newValue) {
                          //         setState(() {
                          //           rememberCheck = newValue!;
                          //         });
                          //       },
                          //       controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          //     ),
                          //   )
                          // ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.04,
                          ),
                          BigButton(
                            title: "Đăng nhập",
                            ontap: () {
                              login();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.03,
                          ),

                          GestureDetector(
                            onTap: () {
                              changePage(context, ForgetPassMethodPage());
                            },
                            child: Text(
                              "Quên mật khẩu?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.screenWidth! * 0.04,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.03,
                          ),
                          Center(
                            child: Text(
                              "HOẶC TIẾP TỤC VỚI",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.03,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: CircleAvatar(
                                  radius: SizeConfig.screenWidth! * 0.06,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/icons/facebook.png",
                                  ),
                                ),
                                onTap: () async {
                                  final LoginResult result = await FacebookAuth
                                      .instance
                                      .login(); // by default we request the email and the public profile
                                  if (result.status == LoginStatus.success) {
                                    final AccessToken accessToken =
                                        result.accessToken!;
                                    print("lol ${accessToken}");
                                  } else {
                                    print(result.status);
                                    print(result.message);
                                  }
                                },
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth! * 0.08,
                              ),
                              InkWell(
                                child: CircleAvatar(
                                  radius: SizeConfig.screenWidth! * 0.065,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/icons/google.png",
                                  ),
                                ),
                                onTap: () async {
                                  try {
                                    _googleSignIn!.signIn().then((result) {
                                      result!.authentication.then((googleKey) {
                                        print(googleKey.accessToken);
                                        print(googleKey.idToken);
                                        print(_googleSignIn!
                                            .currentUser!.displayName);
                                      }).catchError((err) {
                                        print('inner error');
                                      });
                                    }).catchError((err) {
                                      print('error occured');
                                    });
                                  } catch (error) {
                                    print(error);
                                  }
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "CHƯA CÓ TÀI KHOẢN?  ",
                                style: TextStyle(
                                    fontSize: SizeConfig.screenWidth! * 0.04,
                                    fontWeight: FontWeight.w300),
                              ),
                              InkWell(
                                onTap: () {
                                  changePage(context, SignUpPage());
                                },
                                child: Text(
                                  "ĐĂNG KÍ    ",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.045,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn!.disconnect();

  }

  void login() {
    if (phone == null) {
      showToastString("Vui lòng nhập số điện thoại");
      return;
    }
    if (pass == null) {
      showToastString("Vui lòng nhập mật khẩu");
      return;
    }
    BlocProvider.of<AuthBloc>(currentContext).add(LoadingE());
    BlocProvider.of<AuthBloc>(currentContext)
        .add(LoginE(LoginRequest(username: phone, password: pass)));
  }
}
