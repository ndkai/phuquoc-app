import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/chatbot/presentation/pages/chat_page.dart';
import 'package:phuquoc/feature/home_page/presentation/widgets/app_function.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_bloc.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_event.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_state.dart';

import '../../../../injection_container.dart';

class HomePage extends StatefulWidget {
  final BuildContext? appContext;
  const HomePage({Key? key, this.appContext}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserInfoSwagger? userInfoSwagger;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
      child: Scaffold(
        floatingActionButton: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight! * 0.07,
          padding: EdgeInsets.all(5),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: SizeConfig.screenWidth! * 0.34,
                height: SizeConfig.screenHeight! * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text(
                      "  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Image.asset("assets/images/enmergency.png", width: SizeConfig.screenWidth! * 0.1, height: SizeConfig.screenHeight! * 0.04,),
                    Text(
                      "  CẤP CỨU",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  changePage(widget.appContext!, ChatPage());
                },
                child: Container(
                  height: SizeConfig.screenHeight! * 0.06,
                  width: SizeConfig.screenWidth! * 0.13,
                  // padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(right: SizeConfig.screenWidth! * 0.07),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(
                      Icons.headset_mic_rounded,
                      color: Colors.white,
                      size: SizeConfig.screenWidth! * 0.07,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: BlocProvider<UserBloc>(
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
                Navigator.pop(widget.appContext!);
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
              return WillPopScope(
                onWillPop: _onWillPop,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      image: DecorationImage(
                          image: AssetImage("assets/bgs/homepage_bg.png"))),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.05),
                  height: SizeConfig.screenHeight,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.08,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userInfoSwagger!= null ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: SizeConfig.screenHeight! * 0.01,
                              ),
                              Text(
                                "Xin chào",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: SizeConfig.screenWidth! * 0.045,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${userInfoSwagger!.data!.userInfo!.fullName}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: SizeConfig.screenWidth! * 0.05,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ) : Container(height: SizeConfig.screenHeight! * 0.01,),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: SizeConfig.screenWidth! * 0.05,
                            // child: Image.asset("ass"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.05,
                      ),
                      Container(
                        height: SizeConfig.screenHeight! * 0.2,
                        child: Stack(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight! * 0.18,
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth! * 0.05,
                                  vertical: SizeConfig.screenHeight! * 0.02),
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade600,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Thông tin Covid-19",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.screenWidth! * 0.06),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight! * 0.01,
                                  ),
                                  Text(
                                    "Cùng chúng tôi tìm hiểu các thông tin về Covid-19",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeConfig.screenWidth! * 0.035),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                left: SizeConfig.screenWidth! * 0.05,
                                child: Image.asset(
                                  "assets/images/illustration.png",
                                  width: SizeConfig.screenWidth! * 0.25,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.05,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dịch vụ của chúng tôi",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth! * 0.045,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        // color: Colors.black87,
                        // height: 300,
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(15)
                        // ),
                        width: SizeConfig.screenWidth,
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GridView.count(
                                primary: true,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                childAspectRatio: 1,
                                //tỷ lệ width/height
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                // padding: const EdgeInsets.all(5),
                                children: appFunction(widget.appContext!))),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
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
