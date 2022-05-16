import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:phuquoc/feature/vaccination/data/models/test_result.dart';

abstract class VaccinationDatasource{
  Future<TestResult> getTestResult(String phoneNumber);
}

class VaccinationDatasourceImpl implements VaccinationDatasource{
  final Dio client;

  VaccinationDatasourceImpl(this.client);

  @override
  Future<TestResult> getTestResult(String phoneNumber) {
    return _getTestResult(phoneNumber);
  }

  Future<TestResult> _getTestResult(String phoneNumber) async{
    try{
      final body = jsonEncode({
        'phonenumber': '0946706143'
      });
      final _result = await client.request<String>('https://smarthatien.bakco.vn/api/Seach/SearchDetailReports',
          options:  Options(
              method: 'POST',
            headers: <String, dynamic>{},
          ),
          data: body);
      if(_result.statusCode == 200){
        List<dynamic> json = jsonDecode(_result.data!);
        var value = json
            .map((dynamic i) => TestResultData.fromJson(i as Map<String, dynamic>))
            .toList();
        TestResult testResult = TestResult();
        testResult.data = value;
        return testResult;
      } else{
        return TestResult(error: _result.data!);
      }
    }
    catch(e){
      print("_getTestResult ${e}");
      return TestResult(error: e.toString());
    }
  }


}