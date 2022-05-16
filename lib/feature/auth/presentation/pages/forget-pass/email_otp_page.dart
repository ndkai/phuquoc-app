import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/domain/entities/otp-request.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:phuquoc/feature/auth/presentation/pages/forget-pass/reset-pass.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_input_field.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';

import '../../../../../injection_container.dart';

class EmailOtpPage extends StatefulWidget {
  final String? emal;
  const EmailOtpPage({Key? key, this.emal}) : super(key: key);

  @override
  _EmailOtpPageState createState() => _EmailOtpPageState();
}

class _EmailOtpPageState extends State<EmailOtpPage> {
  late BuildContext currentContext;
  late String otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state){
            if(state is AuthLoading){
              showLoadingDialog(context);
            } else
            if(state is ComfirmOtpLoaded){
              Navigator.of(context).pop();
              showToastString("Xác thực thành công");
              changePage(context, ResetPassPage(comfirmOtp: state.comfirmOtp,));
            } else
            if(state is AuthError){
              Navigator.of(context).pop();
              showToastString("${state.msg}");
            } else
            if(state is GenerateOtpLoaded){
              Navigator.of(context).pop();
              showToastString("Gửi lại mã thành công");
            }
          },
          builder: (context, state){
            currentContext = context;
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
                            fit: BoxFit.scaleDown
                        )
                    ),
                    child: Center(
                      child: Text("Xác thực OTP", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.08, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight! * 0.29 ,),
                      Center(
                        child: Container(
                          width: SizeConfig.screenWidth! * 0.8,
                          child: Text("Vui lòng nhập mã OTP đã được gửi đến email ${widget.emal}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.04, fontWeight: FontWeight.w400),),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.05 ,),
                      RoundedInputField(
                        width: SizeConfig.screenWidth! * 0.9,
                        icon: Icons.lock,
                        hintText: "Mã OTP",
                        onChanged: (value) {
                          otp = value;
                        },
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.02,),
                      InkWell(
                        onTap: (){
                          BlocProvider.of<AuthBloc>(currentContext).add(LoadingE());
                          BlocProvider.of<AuthBloc>(currentContext).add(GenerateOtpE(OTPRequest(
                              email: widget.emal
                          )));
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text.rich(TextSpan(
                              text: "Không nhận được mã?  ",
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth! * 0.045,
                                  fontWeight: FontWeight.w400
                              ),
                              children: [
                                TextSpan(text: 'Gửi lại     ',style: TextStyle(
                                    fontSize: SizeConfig.screenWidth! * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),),
                              ]
                          )),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.05 ,),
                      BigButton(title: "Xác nhận", ontap: (){
                        BlocProvider.of<AuthBloc>(currentContext).add(LoadingE());
                        BlocProvider.of<AuthBloc>(currentContext).add(ComfirmOtpE(OTPRequest(email: widget.emal, otp: otp)));
                      },),
                      SizedBox(height: SizeConfig.screenHeight! * 0.03 ,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text("HỦY BỎ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.04, fontWeight: FontWeight.w400, color: Colors.blue),),
                      ),
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
}
