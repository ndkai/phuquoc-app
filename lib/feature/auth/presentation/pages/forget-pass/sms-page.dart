import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/domain/entities/otp-request.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_input_field.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';

import '../../../../../injection_container.dart';
import 'otp_page.dart';

class SmsPage extends StatefulWidget {
  const SmsPage({Key? key}) : super(key: key);

  @override
  _SmsPageState createState() => _SmsPageState();
}

class _SmsPageState extends State<SmsPage> {
  late BuildContext currentContext;
  String phone = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state){
            print("AuthState ${state}");
            if(state is AuthLoading){
              showLoadingDialog(context);
            } else
            if(state is GenerateOtpLoaded){
              Navigator.of(context).pop();
              changePage(context, OtpPage(phone: phone,));
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
                      child: Text("Quên mật khẩu", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.08, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight! * 0.29 ,),
                      Center(
                        child: Container(
                          width: SizeConfig.screenWidth! * 0.8,
                          child: Text("Chúng tôi sẽ gửi mã xác thực OTP dến số điện thoại của bạn",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.04, fontWeight: FontWeight.w400),),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.05 ,),
                      RoundedInputField(
                        width: SizeConfig.screenWidth! * 0.9,
                        icon: Icons.phone_android,
                        hintText: "Nhập số điện thoại của bạn",
                        onChanged: (value) {
                          phone = value;
                        },
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.05 ,),
                      BigButton(title: "TIẾP TỤC", ontap: (){
                       try{
                         if(phone == "" || phone.length < 10){
                           showToastString("Số điện thoại không hợp lệ!");
                           return;
                         }
                         BlocProvider.of<AuthBloc>(currentContext).add(LoadingE());
                        BlocProvider.of<AuthBloc>(currentContext).add(GenerateOtpE(OTPRequest(
                          phone: phone
                        )));
                       }catch(e){
                         showToastString("Số điện thoại không hợp lệ!");
                       }
                      },)
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
