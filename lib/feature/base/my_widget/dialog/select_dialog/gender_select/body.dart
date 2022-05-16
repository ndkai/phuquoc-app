import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';

class SelectDialogBody extends StatefulWidget {
  final Function(int)? onSuccess;
  const SelectDialogBody({Key? key, this.onSuccess}) : super(key: key);

  @override
  _SelectDialogBodyState createState() => _SelectDialogBodyState();
}

class _SelectDialogBodyState extends State<SelectDialogBody> {
  int val = -1;
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.4)
        ),
        child: Container(
          height: SizeConfig.screenHeight! * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: Text("Nam"),
                leading: Radio(
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value as int;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
              ListTile(
                title: Text("Nữ"),
                leading: Radio(
                  value: 2,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      print("value ${value}");
                      val = value as int;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.01,),
              Divider(color: Colors.black, height: 1,),
              SizedBox(height: SizeConfig.screenHeight! * 0.02,),
              Expanded(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            // border: Border(
                            //     right: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.2
                            //     )
                            // )
                          ),
                          width: SizeConfig.screenWidth! * 0.25,
                          child: Center(
                            child: Text("Hủy bỏ", style: TextStyle(
                              color: Colors.blue,
                              fontSize: SizeConfig.screenWidth! * 0.045,

                            )),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        widget.onSuccess!
                          (val);
                      },

                      child: Container(
                          decoration: BoxDecoration(
                            // border: Border(
                            //     left: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.2
                            //     )
                            // )
                          ),
                          width: SizeConfig.screenWidth! * 0.25,
                          child: Center(
                            child: Text("Đồng ý", style: TextStyle(
                                color: Colors.blue,
                                fontSize: SizeConfig.screenWidth! * 0.045,
                                fontWeight: FontWeight.bold
                            ),),
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
