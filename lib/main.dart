
import 'package:flutter/material.dart';
import 'package:myfirst_flutter_project/Form_screen.dart';
import 'package:myfirst_flutter_project/bottom_navigator.dart';
import 'package:myfirst_flutter_project/display_screen.dart';
import 'package:myfirst_flutter_project/home_screen.dart';
import 'package:myfirst_flutter_project/login_screen.dart';
import 'package:myfirst_flutter_project/search_screen.dart';
import 'package:myfirst_flutter_project/signup_screen.dart';
import 'package:myfirst_flutter_project/update_screen.dart';
import 'package:myfirst_flutter_project/user_sheet_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await UserSheetApi.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAWYER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SignUpScreen.id,
      routes: {
        LogIn.id :(context) =>  const LogIn(),
        SignUpScreen.id :(context) => const SignUpScreen(),
        BottomNavigation.id :(context) => const BottomNavigation(),
        HomeScreen.id : (context) => const HomeScreen(),
        FormScreen.id :(context) => const FormScreen(),
        DisplayData.id :(context) => const DisplayData(),
        SearchScreen.id :(context) => const SearchScreen(),
        UpdateScreen.id :(context) => const UpdateScreen(),
      },
    );
  }
}