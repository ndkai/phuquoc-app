import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/domain/entities/signup_request.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_input_field.dart';
import 'package:phuquoc/feature/auth/presentation/widgets/components/rounded_password_field.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';

import '../../../../injection_container.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late BuildContext currentContext;
  String? name;
   String? pass;
   String? phone;
   bool missName = false;
   bool missPhone= false;
   bool missPass= false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
         listener: (context, state){
           if(state is AuthLoading){
             showLoadingDialog(context);
           } else
           if(state is SignUpLoaded){
             Navigator.of(context).pop();
             Navigator.of(context).pop();
             showToastString("Đăng kí thành công");
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
                     child: Text("ĐĂNG KÍ", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.08, fontWeight: FontWeight.bold),),
                   ),
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(height: SizeConfig.screenHeight! * 0.25 ,),

                     SizedBox(height: 20,),
                     RoundedInputField(
                       width: SizeConfig.screenWidth! * 0.9,
                       icon: Icons.person,
                       hintText: "Họ và tên",
                       onChanged: (value) {
                         name = value;
                       },
                     ),
                     missName == true ? missingField() :Container(),
                     RoundedPasswordField(
                       width: SizeConfig.screenWidth! * 0.9,
                       title: "Mật Khẩu",
                       onChanged: (value) {
                         pass = value;
                       },
                     ),
                     missPass == true ? missingField() :Container(),
                     RoundedInputField(
                       width: SizeConfig.screenWidth! * 0.9,
                       icon: Icons.phone_android,
                       hintText: "Nhập số điện thoại",
                       onChanged: (value) {
                         phone = value;
                       },
                     ),
                     missPhone == true ? missingField() :Container(),
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
                     SizedBox(height: SizeConfig.screenHeight! * 0.04,),
                     BigButton(
                       title: "Tạo tài khoản",
                       ontap: (){
                          signup();
                       },
                     ),
                     Center(
                       child: Text("", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),),
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

  void signup(){
   
    if(name == null){
      setState(() {
        missName = true;
      });
      showToastString("Vui lòng nhập họ tên");
      return;
    }
    if(pass == null){
      setState(() {
        missPass = true;
      });
      showToastString("Vui lòng nhập số điện thoại");
      return;
    }
    if(phone == null){
      setState(() {
        missPhone = true;
      });
      showToastString("Vui lòng nhập vào số điện thoại");
      return;
    }
    BlocProvider.of<AuthBloc>(currentContext).add(LoadingE());
    BlocProvider.of<AuthBloc>(currentContext).add(SignupE(SignupRequest(username: "${phone}", password: "${pass}", fullName: name)));
  }

  Widget missingField(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.info_outline_rounded, color: Colors.red, size: SizeConfig.screenWidth! * 0.06,),
        SizedBox(width: SizeConfig.screenWidth! * 0.01,),
        Text("Thông tin thiếu",
          style: TextStyle(color: Colors.red, fontSize: SizeConfig.screenWidth! * 0.04)  ,),
        SizedBox(width: SizeConfig.screenWidth! * 0.05,),
      ],
    );
  }
}
