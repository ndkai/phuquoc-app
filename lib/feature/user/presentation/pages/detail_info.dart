import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:phuquoc/core/utils/input_converter.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/base_page.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/district_select/district_select_dialog.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/helper.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/provice.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/province_select/province_select_dialog.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/ward_select/ward_select_dialog.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/gender_select/gender_select_dialog.dart';
import 'package:phuquoc/feature/base/my_widget/display/choosing_field.dart';
import 'package:phuquoc/feature/base/my_widget/display/infor_field.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/data/models/profile_swagger.dart';
import 'package:phuquoc/feature/user/domain/entities/user_update_request.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_bloc.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_event.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_state.dart';
import 'package:phuquoc/feature/user/presentation/widgets/country_picker/country_picker.dart';
import 'package:phuquoc/feature/user/presentation/widgets/country_picker/src/country.dart';

import '../../../../injection_container.dart';

class DetailInfoPage extends StatefulWidget {
  final UserInfoSwagger userInfoSwagger;
  final BuildContext? appContext;
  final Provinces? provinces;
  const DetailInfoPage({Key? key, required this.userInfoSwagger, this.appContext, this.provinces})
      : super(key: key);

  @override
  _DetailInfoPageState createState() => _DetailInfoPageState();
}

class _DetailInfoPageState extends State<DetailInfoPage> {
  late final UserInfo userInfo;
  String proviceString = "";
  String districtString = "";
  String wardString = "";
  String nation = "";
  late Provinces provinces;
  Province? provice;
  Districts? districts;
  Wards? wards;
  String name= '';
  String phone= '';
  String dob = '';
  String email= '';
  String identityCard= '';
  String address= '';
  String passportNumber= '';
  bool? genders;

  ProfileSwagger? profileSwagger;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo = widget.userInfoSwagger.data!.userInfo!;
    print("lolllll ${widget.provinces!.provinces!.length}");
  }

  void resetData(ProfileSwagger profileSwagger){
    name = ( profileSwagger.fullname != null? profileSwagger.fullname : "")!;
    nation = ( profileSwagger.nation!= null? profileSwagger.nation : "")!;
    genders = (profileSwagger.gender != null? profileSwagger.gender : false)!;
    dob =  (profileSwagger.dateOfBirth != null? profileSwagger.dateOfBirth : "")!;
    phone = ( profileSwagger.phoneNumber != null? profileSwagger.phoneNumber : "")!;
    email = ( profileSwagger.email != null? profileSwagger.email : "")!;
    identityCard =  (profileSwagger.identityCard != null? profileSwagger.identityCard: "")!;
    address = (profileSwagger.address != null? profileSwagger.address : "")!;
    proviceString = (profileSwagger.province != null? profileSwagger.province : "")! ;
    wardString =  (profileSwagger.ward != null? profileSwagger.ward : "")!;
    districtString =(profileSwagger.district != null? profileSwagger.district : "")! ;
    passportNumber =(profileSwagger.passportNumber != null? profileSwagger.passportNumber : "")! ;



    try{
      provice = widget.provinces!.provinces!.firstWhere((element) => element.value == proviceString);
    } catch(e){
      print("provice $e");
    }
    try{
      districts = provice!.districts!.firstWhere((element) => element.value == districtString);
    } catch(e){
      print("districts $e");
    }
    try{
      wards = districts!.wards!.firstWhere((element) => element.value == wardString);
    } catch(e){
      print("wards $e");
    }
    if(provice != null){
      proviceString = provice!.label!;
    }
    if(districts != null){
      districtString = districts!.label!;
    }
    if(wards != null){
      wardString = wards!.label!;
    }

  }

  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title: "Thông tin chi tiết",
      margin: 10,
      onBack: () {
        Navigator.of(context).pop();
      },
      child: BlocProvider<UserBloc>(
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
                resetData(profileSwagger!);
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
            return profileSwagger != null? Container(
              height: SizeConfig.screenHeight! * 0.91,
              child: FutureBuilder(
                future: getProvinceFormJson(context),
                builder: (context, data) {
                  if (data.hasData) {
                    provinces = data.data as Provinces;
                    print(
                        "FutureBuilder getProvinceFormJson ${provinces.provinces!.length}");
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.03,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: SizeConfig.screenWidth! * 0.1,
                            backgroundColor: Colors.blue.shade500,
                            // child: Image.asset("assets/icons/.png"),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.02,
                        ),
                        infoField("Họ và tên", "${name}", onchanged: (s){name = s;}),
                        choosingField(
                            "Ngày tháng năm sinh", "${getTimeByString(dob)}",
                            ontap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              maxTime: DateTime(DateTime.now().year + 1, 1, 1),
                              onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            setState(() {
                              dob = date.toIso8601String();
                            });
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.vi);
                        }),
                        choosingField("Giới tính", "${genders!?"Nam": "Nữ"}", ontap: () {
                          showGenderSelectDialog(context, (val) {
                            if (val == 1) {
                              setState(() {
                                genders = true;
                              });
                            } else
                              setState(() {
                                genders = false;
                              });
                          });
                        }),
                        infoField(
                            "Số điện thoại", "${phone}", onchanged: (s){phone = s;}),
                        infoField("Email", "${email}",onchanged: (s){email = s;}),
                        infoField("Địa chỉ", "${address}", onchanged: (s){address = s;}),
                        choosingField("Tỉnh/Thành phố", "${proviceString}",
                            ontap: () {
                          showProvinceSelectDialog(context, provinces, (val) {
                            setState(() {
                              proviceString = (val as Province).label!;
                            });
                            provice = (val as Province);
                          });
                        }),
                        choosingField("Quận/Huyện", "${districtString}",
                            ontap: () {
                          if (provice != null) {
                            showDistrictSelectDialog(context, provice!, (val) {
                              setState(() {
                                districtString = (val as Districts).label!;
                                districts = val;
                              });
                            });
                          } else {
                            showToastString("Chưa chọn tỉnh/thành phố");
                          }
                        }),
                        choosingField("Phường/Xã", "${wardString}", ontap: () {
                          if (districts != null) {
                            showWardSelectDialog(context, districts!, (val) {
                              setState(() {
                                wards = val as Wards;
                                wardString = (val).label!;
                              });
                            });
                          } else {
                            showToastString("Chưa chọn quận/huyện");
                          }
                        }),
                        choosingField("Quốc tịch", "${nation}", ontap: () {
                          showCountryPicker(
                            context: context,
                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                            exclude: <String>['VI'],
                            //Optional. Shows phone code before the country name.
                            showPhoneCode: false,
                            onSelect: (Country country) {
                              setState(() {
                                nation = country.name;
                              });
                              print('Select country: ${country.displayName}');
                            },
                            // Optional. Sets the theme for the country list picker.
                            countryListTheme: CountryListThemeData(
                              // Optional. Sets the border radius for the bottomsheet.
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                              // Optional. Styles the search field.
                              inputDecoration: InputDecoration(
                                labelText: 'Tìm kiếm',
                                hintText: 'Nhập tên quốc gia của bạn',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8)
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),

                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.04,
                        ),
                        BigButton(
                            title: "Cập nhật thông tin",
                            ontap: () {
                              BlocProvider.of<UserBloc>(context)
                                  .add(UserLoadingE());
                              BlocProvider.of<UserBloc>(context)
                                  .add(UpdateUserInforE(UpdateInforRequest(
                                address: address,
                                dateOfBirth: dob,
                                district: districts?.value,
                                email: email,
                                fullname: name,
                                gender: genders,
                                //nam true
                                identityCard: identityCard,
                                nation: nation,
                                passportNumber: passportNumber,
                                phoneNumber: phone,
                                province: provice?.value,
                                status: 0,
                                vaccinationCode: "",
                                ward: wards?.value,
                                id: profileSwagger!.id.toString()
                              )));
                            }),
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.2,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ) : Container();
          },
        ),
      ),
    );
  }
}
