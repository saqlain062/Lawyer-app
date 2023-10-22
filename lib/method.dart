
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Internet Error
class InternetError extends StatelessWidget {
  const InternetError({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column( children: [
          Icon(Icons.error_outline,color: Colors.red,size: 48,),
          Text('Internet Error',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
        ),
      ]
    );
  }
}



//emptyFieldError
class EmptyField extends StatelessWidget {
  const EmptyField({super.key});
  @override
  Widget build(BuildContext context) {
    return  const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline_outlined, color: Colors.red,),
        SizedBox(
          width: 5,
        ),
        Text('Enter Some ID! Try Again', style: TextStyle(fontWeight: FontWeight.bold),)  
      ],
    );
  }
}

// Not Found
class NoFound extends StatelessWidget {
  const NoFound({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_outlined, color: Colors.red,),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Not Found! Try Again', style: TextStyle(fontWeight: FontWeight.bold),)  
                    ],
                  );
  }
}
//Else Error
class ElseError extends StatelessWidget {
  const ElseError({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column( children: [
          Icon(Icons.error_outline,color: Colors.red,size: 48,),
          Text('Else Error',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
        ),
      ]
    );
  }
}

// list Number
String? checklist(value){
  final validlist = RegExp(r'^\d+$');
  if(value.isEmpty){
    return 'Enter Number';
  }else if(!validlist.hasMatch(value)){
    return 'Enter digits only';
  }
  return null;
}
// Phone Number
String? checknumber(value){
  if(value == null || value.isEmpty){
  return 'Enter Phone Number';
  }
  final validPhone = RegExp(r'^\d{4}-?\d{7}$');
  if(!validPhone.hasMatch(value)){
  return 'Enter Correct Number Format';
  }
  return null;
}
// Name 
String? checkname(value){
  final validName = RegExp(r'^[a-zA-Z ]+$ *');
  if(value == null || value.isEmpty){
    return 'Name is required';
  }else if (!validName.hasMatch(value)){
    return 'Enter a valid name';
  }
  return null;
}
//Email Address
String? checkEmail(value){
  final validName = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z.]{2,}$');
  if(value == null || value.isEmpty){
    return 'Email is required';
  }else if (!validName.hasMatch(value)){
    return 'Enter a valid Email';
  }
  return null;
}


//Date

String date(String value){
  final DateFormat format = DateFormat('yyyy-MM-dd');
  int? numericDate = int.parse(value);
  DateTime referenceDate = DateTime(1900, 1, -1);
  DateTime actualDate = referenceDate.add(Duration(days: numericDate));
  return format.format(actualDate);
}

DateTime dateformat(String value){
  //final DateFormat format = DateFormat('yyyy-MM-dd');
  int? numericDate = int.parse(value);
  DateTime referenceDate = DateTime(1900, 1, 1);
  DateTime actualDate = referenceDate.add(Duration(days: numericDate));
  return actualDate;
}


        
        