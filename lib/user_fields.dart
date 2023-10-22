
import 'dart:convert';

class UserFields{
  static const String id = 'ID';
  static const String serial = 'List Number';
  static const String name = 'Name';
  static const String phone = 'Phone';
  static const String previousDate = 'Previous Date';
  static const String nextAppearance = 'Next Appearance';
  static const String nextAction ='Next Action';
  static List<String> getFields() => [id,serial,name,phone,previousDate,nextAppearance,nextAction];
}

class User {
  final int? id;
  final int? serial;
  final String name;
  final String phone;
  final String previousDate;
  final String nextAppearance;
  final String nextAction;

  const User({
    this.id,
    this.serial,
    required this.name,
    required this.phone,
    required this.previousDate,
    required this.nextAppearance,
    required this.nextAction
  });

  static User formJson (Map<String, dynamic> byId) => User(
    id: jsonDecode(byId[UserFields.id]),
    serial: jsonDecode(byId[UserFields.serial]),
    name: byId[UserFields.name],
    phone: byId[UserFields.phone],
    previousDate:byId[UserFields.previousDate],
    nextAppearance: byId[UserFields.nextAppearance],
    nextAction: byId[UserFields.nextAction],
  );
  
  Map<String, dynamic > toJson() => {
    UserFields.id: id,
    UserFields.serial: serial,
    UserFields.name: name,
    UserFields.phone: phone,
    UserFields.previousDate: previousDate,
    UserFields.nextAppearance: nextAppearance,
    UserFields.nextAction: nextAction,
  };
}
