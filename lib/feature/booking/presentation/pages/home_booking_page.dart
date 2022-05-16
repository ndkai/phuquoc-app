
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:isoweek/isoweek.dart';
import 'package:phuquoc/core/utils/my_color.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/my_texts.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/base_page.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/base/my_widget/map/goong_map_api/model/bcscmap_response.dart';
import 'package:phuquoc/feature/base/my_widget/map/mapbox_search.dart';
import 'package:phuquoc/feature/booking/presentation/manager/booking/bloc.dart';
import 'package:phuquoc/feature/booking/presentation/pages/booking-his-page.dart';
import 'package:phuquoc/feature/booking/presentation/widgets/time_line/home_booking_time_line.dart';
import 'package:phuquoc/feature/booking/presentation/widgets/time_line/time_line.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_bloc.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_event.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_state.dart';

import '../../../../injection_container.dart';

class HomeBookingPage extends StatefulWidget {
  const HomeBookingPage({Key? key}) : super(key: key);

  @override
  _HomeBookingPageState createState() => _HomeBookingPageState();
}

class _HomeBookingPageState extends State<HomeBookingPage> {
  late BuildContext currentContext;
  late Week week;
  late int currentMonth;
  late int currentYear;
  String choosingTime = "";
  UserInfoSwagger? userInfoSwagger;
  String? addressC = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    week = Week.current();
    currentMonth = DateTime.now().month;
    currentYear = DateTime.now().year;
    if (DateTime.now().hour >= 12) {
      choosingTime = "${DateTime.now().hour} : ${DateTime.now().minute} PM";
    } else
      choosingTime = "${DateTime.now().hour} : ${DateTime.now().minute} AM";
  }

  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title: "Chọn thời gian",
      onBack: () {
        Navigator.of(context).pop();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BookingBloc>(
            create: (_) => sl<BookingBloc>(),
          ),
          BlocProvider<UserBloc>(create: (_) => sl<UserBloc>())
        ],
        child: Column(
          children: [
            BlocConsumer<UserBloc, UserState>(builder: (context, state) {
              if (state is UserInitial) {
                BlocProvider.of<UserBloc>(context).add(UserLoadingE());
                BlocProvider.of<UserBloc>(context).add(GetUserInfoE());
              }
              return Container();
            }, listener: (context, state) {
              if (state is UserLoading) {
                showLoadingDialog(context);
              } else if (state is UserError) {
                Navigator.of(context).pop();
                showToastString(state.msg);
              } else if (state is GetUserInfoLoaded) {
                Navigator.of(context).pop();
                setState(() {
                  userInfoSwagger = state.userInfoSwagger;
                });
              }
            }),
            BlocConsumer<BookingBloc, BookingState>(
              listener: (context, state) {
                print("HomeBookingPage state ${state}");
                if (state is BookingLoading) {
                  showLoadingDialog(context);
                } else if (state is BookingError) {
                  Navigator.of(context).pop();
                  showToastString(state.msg);
                } else if (state is BookingLoaded) {
                  Navigator.of(context).pop();
                  showSuccesDialog();
                }
              },
              builder: (context, state) {
                currentContext = context;
                if (state is BookingInitial) {}
                return Container(
                  height: SizeConfig.screenHeight! * 0.91,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: SizeConfig.screenWidth! * 0.28,
                              height: SizeConfig.screenHeight! * 0.06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButton<int>(
                                    hint: Text(
                                      "Tháng $currentMonth",
                                      style: normalBoldTextStyle,
                                    ),
                                    items: <int>[
                                      1,
                                      2,
                                      3,
                                      4,
                                      5,
                                      6,
                                      7,
                                      8,
                                      9,
                                      10,
                                      11,
                                      12
                                    ].map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          "Tháng ${value}",
                                          style: normalBoldTextStyle,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (s) {
                                      setState(() {
                                        currentMonth = s!;
                                        timeLineKey.currentState!.changeDate(
                                            currentMonth, currentYear);
                                      });
                                    },
                                  ),
                                ],
                              )),
                          Container(
                              width: SizeConfig.screenWidth! * 0.28,
                              height: SizeConfig.screenHeight! * 0.06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButton<int>(
                                    hint: Text(
                                      "Năm ${currentYear}",
                                      style: normalBoldTextStyle,
                                    ),
                                    items: <int>[
                                      // 2021,
                                      2022,
                                      2023,
                                      2024,
                                      2025,
                                      2026
                                    ].map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          "${value}",
                                          style: normalBoldTextStyle,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (s) {
                                      setState(() {
                                        currentYear = s!;
                                        timeLineKey.currentState!.changeDate(
                                            currentMonth, currentYear);
                                      });
                                    },
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.02,
                      ),
                      HomeBookingTimeLine(
                        key: timeLineKey,
                        activeDate: DateTime.now(),
                        curentYear: currentYear,
                        currentMonth: currentMonth,
                        onChangeDay: (d) {},
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.04,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thời gian đặt lịch:    ",
                            style: mediumBoldTextStyle,
                          ),
                          InkWell(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue.withOpacity(0.8)),
                              child: Text(
                                '$choosingTime',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.04,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Đia chỉ nơi đặt lịch:    ",
                            style: mediumBoldTextStyle,
                          ),
                          InkWell(
                            onTap: () {
                              getLocation();
                            },
                            child: Container(
                              padding:  EdgeInsets.all(SizeConfig.screenWidth! * 0.02),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // height: SizeConfig.screenHeight! * 0.04,
                              child: Row(
                                children: [
                                  Image.asset("assets/icons/google-maps.png", width: SizeConfig.screenWidth! * 0.05 ,),
                                  Text(
                                    "  Chọn nơi đặt lịch",
                                    style: normalFadeTextStyle,
                                  )
                                ],
                              ),

                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.02,
                      ),
                      Text(
                        "Địa chỉ: ${addressC}",
                        style: normalFadeTextStyle,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.04,
                      ),
                      BigButton(
                        title: "Hoàn tất đặt lịch",
                        ontap: () {
                          // if(interval == null){
                          //   showToastString("Bạn chưa chọn thời gian đặt lịch!");
                          //   return;
                          // }
                          // BlocProvider.of<BookingBloc>(context).add(BookingLoadingE());
                          // BlocProvider.of<BookingBloc>(context).add(BookingE(
                          //     BookingRequest(
                          //         interval: MInterval(
                          //             id: interval!.id,
                          //             from: interval!.from,
                          //             to: interval!.to,
                          //             numId: interval!.numId
                          //         ),
                          //         unit: Unit(
                          //             id: widget.hospitalData!.id,
                          //             name: widget.hospitalData!.name,
                          //             address: widget.hospitalData!.address,
                          //             username: widget.hospitalData!.username,
                          //             districtCode: widget.hospitalData!.district,
                          //             information: widget.hospitalData!.introduction,
                          //             provinceCode: widget.hospitalData!.province,
                          //             wardCode: widget.hospitalData!.ward
                          //         ),
                          //         doctor: Doctor(
                          //             id: dateByServiceAndUnit!.doctor!.id,
                          //             description: dateByServiceAndUnit!.doctor!.description
                          //         ),
                          //         room: Room(
                          //             id: dateByServiceAndUnit!.room!.id,
                          //             name: dateByServiceAndUnit!.room!.description
                          //         ),
                          //         service: Room(
                          //             id: "9f9e8dd3-890e-4ae5-2952-08d92b03ae12",
                          //             name: "Tư vấn"
                          //         ),
                          //         customer: Customer(
                          //           id: userInfoSwagger!.data!.userInfo!.id,
                          //           email: userInfoSwagger!.data!.userInfo!.email,
                          //           username: userInfoSwagger!.data!.userInfo!.username,
                          //           fullname: userInfoSwagger!.data!.userInfo!.fullName,
                          //           phone: userInfoSwagger!.data!.userInfo!.phoneNumber,
                          //           birthDate: DateTime.now().toIso8601String(),
                          //
                          //         ),
                          //         date: DateTime.now().toIso8601String(),
                          //         consultingContent: ConsultingContent(
                          //           content: "",
                          //           note: "",
                          //           result:  "",
                          //           type:  "",
                          //         ),
                          //         testingContent: TestingContent(
                          //         ),
                          //         exitInformation: ExitInformation()
                          //     )
                          // ));
                        },
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void showSuccesDialog() {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Center(
            child: Text(
              'ĐẶT LỊCH THÀNH CÔNG',
              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight! * 0.4,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/Doctor-rafiki 1.png",
                  height: SizeConfig.screenHeight! * 0.2,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.04,
                ),
                BigButton(
                  title: "Lịch sử đặt khám",
                  ontap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    changePage(context, BookingHisPage());
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Trang chủ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth! * 0.04,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getLocation() async {
    showLoadingDialog(context);
    // Location location = new Location();
    //
    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    // LocationData _locationData;
    //
    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     Navigator.of(context).pop();
    //     return;
    //   }
    // }
    //
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     Navigator.of(context).pop();
    //     return;
    //   }
    // }
    //
    // _locationData = await location.getLocation();
    Navigator.of(context).pop();
    try {
      BSSCMapResponse bsscMapResponse = await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  BCSCMap(LatLng(10.216650968575856, 103.95891651698841))));
      setState(() {
        addressC = bsscMapResponse.address;
      });
    } catch (e) {}
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked_s != null && picked_s != selectedTime) {
      setState(() {
        if (picked_s.hour >= 12) {
          choosingTime = "${picked_s.hour} : ${picked_s.minute} PM";
        } else
          choosingTime = "${picked_s.hour} : ${picked_s.minute} AM";
      });
    } else {}
  }
}
