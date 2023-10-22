import 'package:flutter/material.dart';
import 'package:myfirst_flutter_project/bottom_navigator.dart';
import 'package:myfirst_flutter_project/signup_screen.dart';

class LogIn extends StatefulWidget {
  static const String id = 'login';
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool falled = false;

  @override
  void initState() {
    super.initState();
  }

  void check() {
    setState(() {
      falled = true;
    });
  }

  void checkin() {
    setState(() {
      falled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                      height: 100,
                      width: 100,
                      image: AssetImage('images/lawyerIcon.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'Lawyer',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Managment',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Center(
                  child: Text(
                'WELL COME',
                style: TextStyle(fontFamily: 'Rubik Medium', fontSize: 24),
              )),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: const Color(0xffF8F9fa),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.alternate_email,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7Eb)),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7Eb)))),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: const Color(0xffE4E7Eb),
                        filled: true,
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: const Icon(Icons.visibility_off_outlined),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffE4E7Eb))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffE4E7Eb)))),
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline),
                  ),
                ]),
              ),
              const SizedBox(
                height: 70,
              ),
              if (falled)
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      Text('Try Again',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ]),
              TextButton(
                onPressed: () {
                  final email = emailController.text;
                  final pass = passwordController.text;
                  if (email == pass && pass.isNotEmpty) {
                    Navigator.pushNamed(context, BottomNavigation.id);
                    checkin();
                  } else {
                    check();
                  }
                },
                child: Container(
                  height: 50,
                  width: 335,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 110, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text('log In',
                        style: TextStyle(
                            fontFamily: 'Rubik Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account?'),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, SignUpScreen.id);
                  }, child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ))
                  
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
