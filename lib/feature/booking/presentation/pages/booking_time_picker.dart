
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoweek/isoweek.dart';
import 'package:phuquoc/core/utils/my_color.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/my_texts.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/base_page.dart';
import 'package:phuquoc/feature/base/button/big_button.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/booking/data/models/available_time.dart';
import 'package:phuquoc/feature/booking/data/models/date_by_service_a_unit.dart';
import 'package:phuquoc/feature/booking/data/models/hospital_swagger.dart';
import 'package:phuquoc/feature/booking/data/models/service-and-date.dart';
import 'package:phuquoc/feature/booking/domain/entities/booking_request.dart';
import 'package:phuquoc/feature/booking/presentation/manager/booking/bloc.dart';
import 'package:phuquoc/feature/booking/presentation/pages/booking-his-page.dart';
import 'package:phuquoc/feature/booking/presentation/widgets/time_line/time_line.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_bloc.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_event.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_state.dart';

import '../../../../injection_container.dart';

class BookingTimePage extends StatefulWidget {
  final HospitalData? hospitalData;

  const BookingTimePage({Key? key, this.hospitalData}) : super(key: key);

  @override
  _BookingTimePageState createState() => _BookingTimePageState();
}

class _BookingTimePageState extends State<BookingTimePage> {
  late BuildContext currentContext;
  late Week week;
  late int currentMonth;
  late int currentYear;
  int? _value = null;
  ServiceAndDateSwagger? serviceAndDateSwagger;
  DateByUnitAServiceSwagger? dateByUnitAServiceSwagger;
  AvalableTime? avalableTime;
  //boking post
  Times? interval;
  DateByServiceAndUnit? dateByServiceAndUnit;
  UserInfoSwagger? userInfoSwagger;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    week = Week.current();
    currentMonth = DateTime.now().month;
    currentYear = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title: "Chọn thời gian",
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
            BlocConsumer<UserBloc, UserState>(
                builder: (context, state){
                  if(state is UserInitial){
                    BlocProvider.of<UserBloc>(context).add(UserLoadingE());
                    BlocProvider.of<UserBloc>(context).add(GetUserInfoE());
                  }
                  return Container();
                },
                listener: (context, state){
                  if(state is UserLoading){
                    showLoadingDialog(context);
                  } else
                  if(state is UserError){
                    Navigator.of(context).pop();
                    showToastString(state.msg);
                  } else
                  if(state is GetUserInfoLoaded){
                    Navigator.of(context).pop();
                    setState(() {
                      userInfoSwagger = state.userInfoSwagger;
                    });
                  }
                }
            ),
            BlocConsumer<BookingBloc, BookingState>(
              listener: (context, state) {
                print("BookingTimePage state ${state}");
                if (state is BookingLoading) {
                  showLoadingDialog(context);
                } else if (state is BookingError) {
                  Navigator.of(context).pop();
                  showToastString(state.msg);
                } else if (state is GetServiceADateLoaded) {
                  Navigator.of(context).pop();
                  setState(() {
                    serviceAndDateSwagger = state.data;
                  });
                } else if (state is GetDateByUnitAServiceLoaded) {
                  Navigator.of(context).pop();
                  setState(() {
                    dateByUnitAServiceSwagger = state.data;
                  });
                } else if (state is GetAvailableTimeLoaded) {
                  Navigator.of(context).pop();
                  setState(() {
                    avalableTime = state.data;
                  });
                } else
                if(state is BookingLoaded){
                  Navigator.of(context).pop();
                  showSuccesDialog();
                }
              },
              builder: (context, state) {
                currentContext = context;
                if (state is BookingInitial) {
                  BlocProvider.of<BookingBloc>(context).add(BookingLoadingE());
                  BlocProvider.of<BookingBloc>(context).add(GetAvailableDateE(
                      widget.hospitalData!.unitTypeId.toString()));
                  BlocProvider.of<BookingBloc>(context).add(BookingLoadingE());
                  BlocProvider.of<BookingBloc>(context).add(GetDateByUnitAServiceE(
                      widget.hospitalData!.id!,
                      "9f9e8dd3-890e-4ae5-2952-08d92b03ae12"));
                }
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
                                      "Tháng ${currentMonth}",
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
                                        timeLineKey.currentState!
                                            .changeDate(currentMonth, currentYear);
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
                                    items: <int>[2021, 2022, 2023, 2024, 2025, 2026]
                                        .map((int value) {
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
                                        timeLineKey.currentState!
                                            .changeDate(currentMonth, currentYear);
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
                      dateByUnitAServiceSwagger != null
                          ? MyTimeLine(
                        key: timeLineKey,
                        activeDate: DateTime.now(),
                        curentYear: currentYear,
                        currentMonth: currentMonth,
                        availableDay: dateByUnitAServiceSwagger,
                        onChangeDay: (d) {
                          dateByServiceAndUnit = d;
                          BlocProvider.of<BookingBloc>(context)
                              .add(BookingLoadingE());
                          // BlocProvider.of<BookingBloc>(context)
                          //     .add(GetServiceADateE("", ""));
                          BlocProvider.of<BookingBloc>(context)
                              .add(GetAvailableTimeE(d.id!));
                        },
                      )
                          : Container(),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.04,
                      ),
                      Text(
                        "Chọn thời gian muốn đặt khám",
                        style: normalBoldTextStyle,
                      ),
                      avalableTime != null
                          ? Wrap(
                        children: List<Widget>.generate(
                          avalableTime!.times!.length,
                              (int index) {
                            return Container(
                              child: ChoiceChip(
                                label: Text(
                                    '${avalableTime!.times![index].from}'),
                                selected: _value == index,
                                onSelected: (bool selected) {
                                  setState(() {
                                    interval = selected ? avalableTime!.times![index] : null;
                                    _value = selected ? index : null;
                                  });
                                },
                              ),
                              margin: EdgeInsets.all(10),
                            );
                          },
                        ).toList(),
                      )
                          : Container(),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.04,
                      ),
                      BigButton(
                        title: "Hoàn tất đặt lịch",
                        ontap: () {
                          if(interval == null){
                            showToastString("Bạn chưa chọn thời gian đặt lịch!");
                            return;
                          }
                          BlocProvider.of<BookingBloc>(context).add(BookingLoadingE());
                          BlocProvider.of<BookingBloc>(context).add(BookingE(
                              BookingRequest(
                                  interval: MInterval(
                                      id: interval!.id,
                                      from: interval!.from,
                                      to: interval!.to,
                                      numId: interval!.numId
                                  ),
                                  unit: Unit(
                                      id: widget.hospitalData!.id,
                                      name: widget.hospitalData!.name,
                                      address: widget.hospitalData!.address,
                                      username: widget.hospitalData!.username,
                                      districtCode: widget.hospitalData!.district,
                                      information: widget.hospitalData!.introduction,
                                      provinceCode: widget.hospitalData!.province,
                                      wardCode: widget.hospitalData!.ward
                                  ),
                                  doctor: Doctor(
                                      id: dateByServiceAndUnit!.doctor!.id,
                                      description: dateByServiceAndUnit!.doctor!.description
                                  ),
                                  room: Room(
                                      id: dateByServiceAndUnit!.room!.id,
                                      name: dateByServiceAndUnit!.room!.description
                                  ),
                                  service: Room(
                                      id: "9f9e8dd3-890e-4ae5-2952-08d92b03ae12",
                                      name: "Tư vấn"
                                  ),
                                  customer: Customer(
                                    id: userInfoSwagger!.data!.userInfo!.id,
                                    email: userInfoSwagger!.data!.userInfo!.email,
                                    username: userInfoSwagger!.data!.userInfo!.username,
                                    fullname: userInfoSwagger!.data!.userInfo!.fullName,
                                    phone: userInfoSwagger!.data!.userInfo!.phoneNumber,
                                    birthDate: DateTime.now().toIso8601String(),

                                  ),
                                  date: DateTime.now().toIso8601String(),
                                  consultingContent: ConsultingContent(
                                    content: "",
                                    note: "",
                                    result:  "",
                                    type:  "",
                                  ),
                                  testingContent: TestingContent(
                                  ),
                                  exitInformation: ExitInformation()
                              )
                          ));
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
}