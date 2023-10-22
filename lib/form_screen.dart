


import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:myfirst_flutter_project/bottom_navigator.dart';
import 'package:myfirst_flutter_project/method.dart';
import 'package:myfirst_flutter_project/user_fields.dart';
import 'package:myfirst_flutter_project/user_sheet_api.dart';
import 'package:intl/intl.dart';



class FormScreen extends StatefulWidget {
  static const String id = 'form_screen';
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  late TextEditingController serialNoController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController previousDateController = TextEditingController();
  late TextEditingController nextAppearanceController = TextEditingController();
  late TextEditingController nextActionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final DateFormat format = DateFormat('yyyy-MM-dd');
  dynamic idshow;
  dynamic nameShow;
  bool saved = false;
  bool internet = false;
  bool showform = true;
  bool isloading = false;
  late Timer errorTimer;
  User? user;

  void checkinternet(){
    setState(() {
      internet = true;
      errorTimer = Timer(const Duration(seconds: 5), (){
        internet = false;
      });
    });
  }
  void newform(){
    setState(() {
      showform= true;
      saved = false;
    });
  }

  Future <void> previousDate(BuildContext context) async{
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: selectedDate, 
      firstDate: selectedDate, 
      lastDate: DateTime(2100));

      if(dateTime != null ){
        setState(() {
          previousDateController.text = format.format(dateTime);
        });
      }
  }

  Future <void> nextDate(BuildContext context) async{
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: selectedDate, 
      firstDate: selectedDate, 
      lastDate: DateTime(2100));

      if(dateTime != null ){
       // final dateOnly = DateTime(dateTime.year,dateTime.month,dateTime.day);
        setState(() {
          // nextAppearanceController.text = dateOnly.toLocal().toString().split(' ')[0];
          nextAppearanceController.text = format.format(dateTime);
        });
      }
  }
  // void showSnackBar(String message){
  //   scaffoldKey.currentState?.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // }

  @override
  void dispose() {
    errorTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Client Information'),
        ),
        body: Padding(padding: const EdgeInsets.only(left: 30 , right: 30, top: 20, bottom: 10),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
              if(showform)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const Text('Enter New Client Information', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              TextFormField(
               controller: serialNoController,
                decoration: const InputDecoration( 
                labelText:'List Number',
                hintText: '0-9',
                border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  return checklist(value);
                }
                  // value != null && value.isEmpty ? 'Enter List Number': null,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return checkname(value);
                }
                // value != null && value.isEmpty ? 'Enter Name ': null,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: '0300-0000000',
                  label: Text('Phone Number'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return checknumber(value);
                  // if(value == null || value.isEmpty){
                  //   return 'Enter Phone Number';
                  // }
                  // final validPhone = RegExp(r'^\d{4}-\d{7}$');
                  // if(!validPhone.hasMatch(value)){
                  //   return 'Enter Correct Format';
                  // }
                  //  return null;
                } 
                
              ),
                const SizedBox(height: 10,),
              TextFormField(
                controller: previousDateController,
                readOnly: true,
                onTap: () => previousDate(context),
                decoration: const InputDecoration(
                  label: Text('Previous Date'),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_month_outlined),
                ),
                validator: (value) => 
                value != null && value.isEmpty ? 'Enter Previous Date': null,
              ),
                const SizedBox(height: 10,),
              TextFormField(
                controller: nextAppearanceController,
                readOnly: true,
                onTap: () => nextDate(context),
                decoration: const InputDecoration(
                  label: Text('Next Appearance'),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_month_outlined)
                ),
                validator: (value) => 
                value != null && value.isEmpty ? 'Enter Next Appearance': null,
              ),
                const SizedBox(height: 10,),
              TextFormField(
                controller: nextActionController,
                decoration: const InputDecoration(
                  label: Text('Next Action'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => 
                value != null && value.isEmpty ? 'Enter Next Action': null,
              ),
              const SizedBox(height: 10,),
              ],),

              if(internet)
              const InternetError(),
              
              if(showform)
              Center(
                child: ElevatedButton(onPressed: () async {
                  var connectivityResult = await
                  Connectivity().checkConnectivity();
                  if(connectivityResult == ConnectivityResult.none){
                    checkinternet();
                  }else{
                    final form = formkey.currentState!;
                    final isValid = form.validate();
                    if (isValid){
                      final id = await UserSheetApi.getRowCount() + 1;
                      idshow =id;
                        final intSerial = int.tryParse(serialNoController.text);
                        if( intSerial == null){
                          return;
                        }
                        await UserSheetApi.insert([User(id: id,
                        serial: intSerial,
                        name: nameController.text, 
                        phone: phoneController.text,
                        previousDate: previousDateController.text,
                        nextAppearance: nextAppearanceController.text,
                        nextAction: nextActionController.text).toJson()]
                      );
                      nameShow = nameController.text;
                      serialNoController.clear();
                      nameController.clear();
                      phoneController.clear();
                      previousDateController.clear();
                      nextAppearanceController.clear();
                      nextActionController.clear();
                      // showSnackBar('Successfully Stored');
                      setState(() {
                        saved = true;
                        showform = false;
                        internet = false;
                      });
                    }
                  }   
                },child: const Text('Save Data'),),
              ),
              if(saved)
              Column(
                children: [
              const Text('Data Save Successfully' ,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 30),),
              const Divider(
                height: 30,
                thickness: 10,
                indent: 10,
                endIndent: 10,
                color: Colors.lightBlue,
              ),
              Text(' $nameShow ID is "$idshow"',style: const TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),),
              const Divider(
                height: 30,
                thickness: 10,
                indent: 10,
                endIndent: 10,
                color: Colors.lightBlue,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Do You Want To Enter One More',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                  ElevatedButton(onPressed: () {
                    newform();
                  },child: const Text('Yes'),),
                  ElevatedButton(onPressed: (){
                    Navigator.pushNamed(context, BottomNavigation.id);
                  }, child: const Text('No'))
                ]),
              )
            ],
              ),
            ]),
            
          ),
        ),),
      ),
    );
  }


}

