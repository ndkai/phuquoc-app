import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/data/models/comfirm_otp.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:phuquoc/feature/auth/presentation/pages/login_page.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/rounded_password_field.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';

import '../../../../../injection_container.dart';

class ResetPassPage extends StatefulWidget {
  final ComfirmOtp? comfirmOtp;
  const ResetPassPage({Key? key, this.comfirmOtp}) : super(key: key);

  @override
  _ResetPassPageState createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  late BuildContext currentContext;
  String newpass = "";
   String cnewpass ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state){
            print("AuthBloc ${state}");
            if(state is AuthLoading){
              showLoadingDialog(context);
            } else
            if(state is ResetPassLoaded){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              showToastString("Đổi mật khẩu thành công");
              changePageWithReplacement(context, LoginPage());
            } else
            if(state is AuthError){
              Navigator.of(context).pop();
              showToastString("${state.msg}");
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
                      child: Text("THIẾT LẬP MẬT KHẨU", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.08, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: SizeConfig.screenHeight! * 0.29 ,),
                        SizedBox(height: SizeConfig.screenHeight! * 0.05 ,),
                        RoundedPasswordField(
                          width: SizeConfig.screenWidth! * 0.9,
                          title: "Mật Khẩu",
                          onChanged: (value) {
                            newpass = value;
                          },
                        ),
                        RoundedPasswordField(
                          width: SizeConfig.screenWidth! * 0.9,
                          title: "Nhập Lại Mật Khẩu",
                          onChanged: (value) {
                            cnewpass = value;
                          },
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.02,),
                        SizedBox(height: SizeConfig.screenHeight! * 0.05 ,),
                        BigButton(title: "Xác nhận", ontap: (){
                          if(newpass != cnewpass){
                            showToastString("Xác thực mật khẩu không đúng");
                          } else{
                            BlocProvider.of<AuthBloc>(currentContext).add(LoadingE());
                            BlocProvider.of<AuthBloc>(currentContext).add((ResetPassE(
                                "${newpass},${widget.comfirmOtp!.accessToken}"
                            )));
                          }
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
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
