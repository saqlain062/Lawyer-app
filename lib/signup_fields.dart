
import 'dart:convert';

class SignupFields{
  static const String id = 'ID';
  static const String category = 'Category';
  static const String firstName = 'First Name';
  static const String secondName = 'Second Name';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPass = 'Confirm Password';
  static List<String> getFields() => [id,category,firstName,secondName,email,password,confirmPass];
}

class Signup{
  final int? id;
  final String category;
  final String firstName;
  final String secondName;
  final String email;
  final String password;
  final String confirmPass;

  const Signup({
    this.id,
    required this.category,
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.password,
    required this.confirmPass,
  });

  static Signup formJson (Map<String, dynamic> byId) => Signup(
    id: jsonDecode(byId[SignupFields.id]),
    category: byId[SignupFields.category],
    firstName: byId[SignupFields.firstName],
    secondName: byId[SignupFields.secondName],
    email: byId[SignupFields.email],
    password: byId[SignupFields.password],
    confirmPass: byId[SignupFields.confirmPass]
  );

  Map<String, dynamic > toJson() => {
    SignupFields.id: id,
    SignupFields.category: category,
    SignupFields.firstName: firstName,
    SignupFields.secondName: secondName,
    SignupFields.email: email,
    SignupFields.password: password,
    SignupFields.confirmPass: confirmPass,
  };
}