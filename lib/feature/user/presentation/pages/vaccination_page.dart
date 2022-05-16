import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/utils/input_converter.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/base_page.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/base/my_widget/display/infor_field.dart';
import 'package:phuquoc/feature/user/data/models/profile_swagger.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_bloc.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_event.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../injection_container.dart';

class VaccinationPage extends StatefulWidget {
  final BuildContext? appContext;
  const VaccinationPage({Key? key, this.appContext}) : super(key: key);

  @override
  _VaccinationPageState createState() => _VaccinationPageState();
}

class _VaccinationPageState extends State<VaccinationPage> {
  ProfileSwagger? profileSwagger;
  
  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title: "Quản lý tiêm chủng",
      onBack: () {
        Navigator.of(context).pop();
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight! * 0.03,
            ),
            Container(
                padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.1),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.03),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: QrImage(
                          data: "1234567890",
                          version: QrVersions.auto,
                          size: SizeConfig.screenWidth! * 0.4,
                        )),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.03,
                    ),
                    Container(
                      width: SizeConfig.screenWidth! * 0.6,
                      child: Text(
                        "CHỨNG NHẬN ĐÃ TIÊM 2 MŨI VACCIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.screenWidth! * 0.045),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.03,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Thông tin cá nhân",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.screenWidth! * 0.05)),
            ),
            BlocProvider<UserBloc>(
              create: (_) => sl<UserBloc>(),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  print("UserBloc ${state}");
                  if (state is UserLoading) {
                    showLoadingDialog(widget.appContext!);
                  } else if (state is UserError) {
                    Navigator.of(widget.appContext!).pop();
                    showToastString(state.msg);
                  } else if (state is UserProfileLoaded) {
                    Navigator.of(widget.appContext!).pop();
                    setState(() {
                      profileSwagger = state.data;
                    });
                  }   else
                  if(state is UpdateUserInfoLoaded){
                    showToastString("Cập nhật thông tin thành công");
                    Navigator.of(widget.appContext!).pop();
                    Navigator.of(context).pop();
                    setState((){
                    });
                  }
                },
                builder: (context, state) {
                  if (state is UserInitial) {
                    BlocProvider.of<UserBloc>(context).add(UserLoadingE());
                    BlocProvider.of<UserBloc>(context).add(GetUserProfileE(""));
                  }
                  return profileSwagger != null?  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      infoField("Họ và tên", "${profileSwagger!.fullname}"),
                      infoField("Ngày tháng năm sinh", "${getTimeByString(profileSwagger!.dateOfBirth)}"),
                      infoField("Số điện thoại", "${profileSwagger!.phoneNumber}"),
                    ],
                  ): Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
