  
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/auth/presentation/pages/login_page.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/helper.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/provice.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/bloc.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_state.dart';
import 'package:phuquoc/feature/user/presentation/pages/vaccination_page.dart';
import 'package:phuquoc/feature/user/presentation/widgets/user_avatar.dart';
import 'package:phuquoc/feature/vaccination/presentation/pages/test_result_page.dart';

import '../../../../injection_container.dart';
import 'detail_info.dart';

class UserPage extends StatefulWidget {
  final BuildContext? appContext;
  const UserPage({Key? key, this.appContext}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserInfoSwagger? userInfoSwagger;
  late Provinces provinces;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
    ),
    child: Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child:  FutureBuilder(
          future: getProvinceFormJson(context),
          builder: (context, data) {
            if (data.hasData) {
              provinces = data.data as Provinces;
              print(
                  "FutureBuilder getProvinceFormJson ${provinces.provinces!.length}");
            }

            return BlocProvider<UserBloc>(
              create: (_) => sl<UserBloc>(),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state){
                  if(state is UserLoading){
                    showLoadingDialog(context);
                  } else
                  if(state is UserError){
                    Navigator.of(widget.appContext!).pop();
                    showToastString(state.msg);
                  } else
                  if(state is GetUserInfoLoaded){
                    Navigator.of(widget.appContext!).pop();
                    setState(() {
                      userInfoSwagger = state.userInfoSwagger;
                    });
                  }
                },
                builder: (context, state){
                  if(state is UserInitial ){
                    BlocProvider.of<UserBloc>(context).add(UserLoadingE());
                    BlocProvider.of<UserBloc>(context).add(GetUserInfoE());
                  }
                  return Container(
                    height: SizeConfig.screenHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.screenHeight! * 0.08,),
                        userInfoSwagger != null ?
                        UserAvatarVer2(name: "${userInfoSwagger!.data!.userInfo!.fullName}",
                          showDetail: true, phone: "${userInfoSwagger!.data!.userInfo!.phoneNumber ?? ""}",)
                            : UserAvatarVer2(name: "", showDetail: true, phone: "",),
                        horiFunc("assets/icons/bottom_bar/taikhoan.png", "Thông tin cá nhân", ontap: (){
                          changePage(widget.appContext!, DetailInfoPage(userInfoSwagger: userInfoSwagger!, appContext: widget.appContext!, provinces: provinces,));
                        }),
                        horiFunc("assets/icons/tiemchung.png", "Quản lý tiêm chủng  ", ontap: (){
                          changePage(context, VaccinationPage());
                        }),
                        horiFunc("assets/icons/thongtinxn.png", "Thông tin xét nghiệm", ontap: (){
                          showToastString("Tính năng đang phát triển");
                          changePage(widget.appContext!, TestResultPage(phoneNumber: "0946706143", appContext: widget.appContext! ,));
                        }),

                        horiFunc("assets/icons/setting.png", "Cài đặt tài khoản", ontap: (){
                          // changePage(context, AccountSettingPage());
                          showToastString("Tính năng đang phát triển");
                        }),
                        horiFunc("assets/icons/logout.png", "Đăng xuất", ontap: (){
                          prefs!.clear();
                          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return LoginPage();
                              },  
                            ),
                                (_) => false,
                          );
                          // changePage(projectContext!, LoginPage(isLogout: true,));
                        }),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    ),
    );
  }


  Widget horiFunc(String icon, String title, {Function? ontap}){
    return InkWell(
      onTap: (){
        ontap!();
      },
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 6 ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: SizeConfig.screenWidth! * 0.01, ),
                Image.asset(icon, height: SizeConfig.screenWidth! * 0.11, width: SizeConfig.screenWidth! * 0.09, color: Colors.blue
                  ,),
                SizedBox(width: SizeConfig.screenWidth! * 0.04, ),
                Text(title, style: TextStyle(color: Colors.black, fontSize: SizeConfig.screenWidth! * 0.045, fontWeight: FontWeight.w500),),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,size: SizeConfig.screenWidth! * 0.045, color: Colors.blue.withOpacity(0.7),)
          ],
        ),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Thoát?'),
        content: new Text('Bạn thật sự muốn thoát chứ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: new Text('Có'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Không'),
          ),
        ],
      ),
    )) ??
        false;
  }
}
