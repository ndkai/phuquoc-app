import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phuquoc/feature/auth/presentation/pages/login_page.dart';
import 'package:phuquoc/feature/user/presentation/pages/user_page.dart';
import 'package:phuquoc/feature/welcome/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constant/global_var.dart';
import 'feature/home_page/presentation/pages/home_page.dart';
import 'feature/home_page/presentation/widgets/bottom_nar.dart';
import 'injection_container.dart' as di;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
    await di.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])  
      .then((_) {
    runApp(new MyApp());
  });
}

BuildContext? projectContext;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home:  widget(),
      debugShowCheckedModeBanner: false,
      home: widget(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/user': (context) => UserPage(),
        '/bottombar': (context) => MyBottomBar(menuScreenContext: context,),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }

  Widget widget(){
    try{
      bool? b = prefs!.getBool("FIRST_OPEN");
      if(b == false){
        return LoginPage();
      }
      return WelcomePage();
    } catch(e){
       return WelcomePage();
    }
  }
}
