import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfirst_flutter_project/bottom_navigator.dart';
import 'package:myfirst_flutter_project/home_screen.dart';
import 'package:myfirst_flutter_project/login_screen.dart';
import 'package:myfirst_flutter_project/method.dart';
import 'package:myfirst_flutter_project/signup_fields.dart';
import 'package:myfirst_flutter_project/user_sheet_api.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  late TextEditingController controllerFirstName = TextEditingController();
  late TextEditingController controllerEmail = TextEditingController();
  late TextEditingController controllerSecondName = TextEditingController();
  late TextEditingController controllerpassword = TextEditingController();
  late TextEditingController controllerConfirmPassword =
      TextEditingController();
  // final DateFormat format = DateFormat('yyyy-MM-dd');
  // late DateTime dateTime;

  String userType = 'Lawyer';
  bool error = false;

  // Future <void> calender(BuildContext context) async{
  // final DateTime? dateTime = await showDatePicker(
  //   context: context,
  //   initialDate: DateTime.now(),
  //   firstDate: DateTime(1900,1,1),
  //   lastDate: DateTime.now());

  //   if(dateTime != null ){
  //     setState(() {
  //       controllerDoB.text = format.format(dateTime);
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const Image(
                          height: 100,
                          width: 100,
                          image: AssetImage('images/lawyer.png')),
                      const Center(
                          child: Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controllerFirstName,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            label: const Text('First Name'),
                            hintText: 'Enter your first name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                        validator: (value) {
                          return checkname(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controllerSecondName,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            label: const Text('Second Name'),
                            hintText: 'Enter your Second Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                        validator: (value) {
                          return checkname(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            label: const Text('Email'),
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                        validator: (value) {
                          return checkEmail(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // TextFormField(
                      //   readOnly: true,
                      //   onTap: () =>
                      //     calender(context),
                      //   controller: controllerDoB,
                      //   decoration: InputDecoration(
                      //       prefixIcon: const Icon(Icons.calendar_month),
                      //       label: const Text('DOB'),
                      //       hintText: 'Enter your Date of Birth',
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: const BorderSide(width: 4))),
                      // validator: (value) =>
                      // value != null && value.isEmpty ? 'Enter DoB': null,
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      DropdownButtonFormField(
                        value: userType,
                        items: const [
                          DropdownMenuItem(
                            value: 'Lawyer',
                            child: Text('Lawyer'),
                          ),
                          DropdownMenuItem(
                            value: 'Client',
                            child: Text('Other'),
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            userType = value!;
                          });
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.check_circle),
                            labelText: 'Select Category',
                            hintText: 'Lawyer or other',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controllerpassword,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            label: const Text('Password'),
                            hintText: 'Enter your Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Enter Password'
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controllerConfirmPassword,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            label: const Text('Confirm Password'),
                            hintText: 'Enter your Confirm Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Enter Confirm Password'
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (error)
                        const Text(
                          'Check Password',
                          style: TextStyle(color: Colors.red),
                        ),
//Signup Button
                      Row(
                        children: [
                          TextButton(
                            onPressed: () async {
                              final pass = controllerpassword.text;
                              final confirmPass =
                                  controllerConfirmPassword.text;
                              if (pass == confirmPass) {
                                final form = formkey.currentState!;
                                final isValid = form.validate();
                                if (isValid) {
                                  final id =
                                      await UserSheetApi.rowCountSignup() + 1;

                                  await UserSheetApi.insertSignup([
                                    Signup(
                                            id: id,
                                            category: userType,
                                            firstName: controllerFirstName.text,
                                            secondName:
                                                controllerSecondName.text,
                                            email: controllerEmail.text,
                                            password: controllerpassword.text,
                                            confirmPass:
                                                controllerConfirmPassword.text)
                                        .toJson()
                                  ]);
                                }
                                Future.delayed(Duration.zero, () {
                                  if (userType == 'Lawyer') {
                                    Navigator.pushNamed(
                                        context, BottomNavigation.id);
                                  }
                                  if (userType == 'Client') {
                                    Navigator.pushNamed(context, HomeScreen.id);
                                  }
                                });
                              } else {
                                setState(() {
                                  error = true;
                                });
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Center(
                                  child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have a Account?',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LogIn.id);
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.pink, fontSize: 15),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
