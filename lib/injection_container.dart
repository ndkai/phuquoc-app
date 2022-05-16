import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:phuquoc/feature/auth/data/data_sources/auth_datasourse.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/comfirm-otp.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/get_sq_uc.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/login_fb_gg.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/login_uc.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/signup_uc.dart';
import 'package:phuquoc/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:phuquoc/feature/booking/data/data_sources/booking_datasourse.dart';
import 'package:phuquoc/feature/booking/data/repositories/booking-repo-impl.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/booking.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/booking_his.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/delete_booking.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/get-date-by-unit-and-service-uc.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/get_date_available.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/get_service_a_date.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/get_time_available.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/hospital-uc.dart';
import 'package:phuquoc/feature/booking/presentation/manager/booking/bloc.dart';
import 'package:phuquoc/feature/chatbot/data/data_sources/chat_datasource.dart';
import 'package:phuquoc/feature/chatbot/data/repositories/chatrepo_impl.dart';
import 'package:phuquoc/feature/chatbot/domain/repositories/chat-repo.dart';
import 'package:phuquoc/feature/chatbot/domain/use_cases/post_question.dart';
import 'package:phuquoc/feature/chatbot/presentation/manager/chatbot/bloc.dart';
import 'package:phuquoc/feature/user/data/data_sources/user_datasourse.dart';
import 'package:phuquoc/feature/user/data/repositories/user-repo-impl.dart';
import 'package:phuquoc/feature/user/domain/repositories/user-repo.dart';
import 'package:phuquoc/feature/user/domain/use_cases/get_user_info.dart';
import 'package:phuquoc/feature/user/domain/use_cases/get_user_profile_uc.dart';
import 'package:phuquoc/feature/user/domain/use_cases/update_user_info.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/bloc.dart';
import 'package:phuquoc/feature/vaccination/data/data_sources/vaccination_datasource.dart';
import 'package:phuquoc/feature/vaccination/domain/repositories/vaccination_repo.dart';
import 'package:phuquoc/feature/vaccination/domain/use_cases/get_test_result.dart';
import 'package:phuquoc/feature/vaccination/presentation/manager/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/utils/input_converter.dart';
import 'feature/auth/data/repositories/auth_repo_impl.dart';
import 'feature/auth/domain/use_cases/generate-otp.dart';
import 'feature/auth/domain/use_cases/reset-pass.dart';
import 'feature/vaccination/data/repositories/vaccination_repo_impl.dart';
final sl = GetIt.instance;

Future<void> init() async {
   //bloc
  sl.registerFactory(
        () => AuthBloc(sl(),sl(),sl(),sl(),sl(),sl(), sl()),
  );

  sl.registerFactory(
        () => UserBloc(sl(), sl(),sl()),
  );

  sl.registerFactory(
        () => BookingBloc(sl(),sl(),sl(), sl(), sl(), sl(), sl(), sl()),
  );

  sl.registerFactory(
        () => ChatBotBloc(sl()),
  );

  sl.registerFactory(
        () => VaccinationBloc(sl()),
  );
  //usecase
  sl.registerLazySingleton(() => GetTestResultUc(sl()));
  sl.registerLazySingleton(() => GetUserProfileUc(sl()));
  sl.registerLazySingleton(() => UpdateUserInfoUc(sl()));
  sl.registerLazySingleton(() => PostQuestionUc(sl()));
  sl.registerLazySingleton(() => LoginUc(sl()));
  sl.registerLazySingleton(() => SignupUc(sl()));
  sl.registerLazySingleton(() => GetUserInfoUc(sl()));
  sl.registerLazySingleton(() => ComfirmPassUC(sl()));
  sl.registerLazySingleton(() => ResetPassUC(sl()));
  sl.registerLazySingleton(() => GenerateOtpUc(sl()));
  sl.registerLazySingleton(() => LoginFbAGGUc(sl()));
  sl.registerLazySingleton(() => GetSQUC(sl()));
  sl.registerLazySingleton(() => HospitalUc(sl()));
  sl.registerLazySingleton(() => GetTimeAvailableUc(sl()));
  sl.registerLazySingleton(() => GetDateAvailableUc(sl()));
  sl.registerLazySingleton(() => GetServiceADateUc(sl()));
  sl.registerLazySingleton(() => GetDateByUnitAServiceUc(sl()));
  sl.registerLazySingleton(() => BookingUc(sl()));
  sl.registerLazySingleton(() => BookingHisUc(sl()));
  sl.registerLazySingleton(() => DeleteBookingUc(sl()));
  // repo
  sl.registerLazySingleton<VaccinationRepo>(
          () => VaccinationRepoImpl(sl(), sl()));

  sl.registerLazySingleton<ChatRepo>(
          () => ChatRepoImpl(networkInfo: sl(), chatDataSource: sl()));

  sl.registerLazySingleton<BookingRepo>(
          () => BookingRepoImpl(networkInfo: sl(), bookingDatasource: sl()));

  sl.registerLazySingleton<AuthRepo>(
          () => AuthRepoImpl(networkInfo: sl(), authDataSource: sl()));

  sl.registerLazySingleton<UserRepo>(
          () => UserRepoImpl(networkInfo: sl(), datasource: sl()));
  //datasourse
  sl.registerLazySingleton<VaccinationDatasource>(
        () => VaccinationDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<ChatDataSource>(
        () => ChatDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<AuthDataSource>(
        () => AuthDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<BookingDatasource>(
        () => BookingDatasourceImpl(client: sl()),
  );

  sl.registerLazySingleton<UserDatasource>(
        () => UserDatasourceImpl(client: sl()),
  );
  // core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
}
