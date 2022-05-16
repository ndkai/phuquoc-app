import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/provice.dart';

Future<Provinces> getProvinceFormJson(BuildContext context) async {
  String data = await DefaultAssetBundle.of(context).loadString("assets/hanhchinhvn/locations.json");
  final jsonResult = jsonDecode(data);
  Provinces provinces = Provinces.fromJson(jsonResult);
  print("getProvinceFormJson ${provinces.provinces!.length}");
  return provinces;
}