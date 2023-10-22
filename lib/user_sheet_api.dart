
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:myfirst_flutter_project/signup_fields.dart';
import 'package:myfirst_flutter_project/user_fields.dart';

class UserSheetApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-399113",
  "private_key_id": "ee7ebe521f0ce620e649042c0188c463ca5dda45",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDHq1K2zDQ7iPE/\nhrfxAICilCCez4U322x10z9jrBl2MuMEhU7rqQJd93M3FtD0n3SgEumfAJuS7ue3\nr+x3yyPH3q7ZzbLNwD5o1g/J5+KgpAStDqsWq1WuQ0ltGkz9vaBXtJzTPFqnM+Qj\nm32+ZcBM2y1FcV5oexpfqIFIu7CHUdPEWF3HIuXCVit/9OVdqULGZXK8uuySNSFo\n14uAMw1yOQyKqpeokCKaRoX64HZgWn1cFtz2QSB2aWMCjDDjmJo9g8SqWAeSa4mN\nJdMFY1lZ17nCHGnZEsLnHDe45JDDhhQ76cXbvfjjaN+xPBSpfdcvJa6uGxY6YIOJ\nG/SiGeURAgMBAAECggEAXCajPY9gOevZX7bG1Pkk5SPVLEZdVuqzk2uEEXW/qJAS\nuyblRhkR6RlHuPCUTpn7Itenr8UBiB4vnlSYn68G2/tXmlj3gUMM6qiEz+vv6bDZ\nIZ+n8YXwvMT8MdjWGLN4OZI3YLw1oH5v98kPDxz5097B9Y89gZ3zDZwA0vcgoUqe\nkWpn8ChXu7WbBerrxUwE3W68gZusQs7D4RsVVklaNlCEV0K73GEgHtzVTaY4Xn2W\ngXI9+QKVFW3q3Ow/Ja1v/Ob1pPPA/w0yZy5Q7Ar3hLmJjz1JUchHY+JWbZjmunz2\nmla7wLZF0RM0PflyNc77bIoUVJFjnRu/hKzMClzV0wKBgQD3rFkvQA1jyyus8WI+\nse3rz/mIVDBCy8m2xVNBHaeSY9kYBSSmILO+6pm8dJ/ABN87p5S+7PS2x8dyyd/y\nPUtq4UYzqM8Nrxx62BNh258O3Y3320YWGZOL+9pmrTrmkyRNjWlpeCxCkLiYRw5i\n2PsyBNdoaOTUfcog7/2w/kj8iwKBgQDOYdF1FeQilRbGp8/2DhqdfeNLL0UYnwqm\nAlL/eRln3x6a3MAZ8+sPtn0a5CZdSXD2+DVBDZj+DWJ6h43uWrKvgwwjM6d9D7Zj\nVE2+IlC50h+HeDd/2RhGxkXL0MPCmGM4/sk7vHFn2i5U6+SXXgK0Xsoo+uxkSkSp\ndjtnOXyMUwKBgQCC6rVRxpfNUk3J4uY9oavT5GFQcL/57uK3G+MAHn6/YMwWaFGR\nBuQ8XKHa/gKba3fcfp6ftX09SKjiwlcAIupEmsOS9v5Li26QeLr2FTMklnQ+ucd4\nUxis+/ncIGFsFAcyfzdjKsSqgvkwdQ7jrTJKpEiAxkF/GObJNlJxRliqNQKBgFZQ\nQLqYMjZoZgMlUetVULpHWRUrqtk2QszVMgMYkZCIlxMrecgg5FFJAB+MBaOEQJN5\nkUQovLCbxnD6WliyZALVavEZ/FVoid4W9wCq91oP0BHnLEby85099RjdsdGjy/Od\nU2oBUOifLjtkANFxhu4Kqr/i2ZTEHt1EzmlIeJdzAoGAIpf/MQB5CHRa6xqI7V2U\nHkJqPagGW7FMnt1AWb3xz3zN/ImmYv/Rue8h9ZMvUWK9DTEVC54euqBuzNYsVpLI\nhEIcie1T525eZemkE3dxQ6F0l7jBYe4N8885JiFe4cTWn43kZ4TO9Y+DudILDG8d\nIuh8+9EJyuirPQDq0JnLdh4=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-399113.iam.gserviceaccount.com",
  "client_id": "103975133037088787880",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-399113.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';
  static const  _spreadsheetId = '1cQlYMviYiT_Ka-oYJ-eCGi6HuHHYVKmYY1iceGMZQJc';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Worksheet? _signupSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'LawyerClientData');
      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
      _signupSheet = await _getWorkSheet(spreadsheet, title: 'Signup');
      final firstSignupRow = SignupFields.getFields();
      _signupSheet!.values.insertRow(1, firstSignupRow);
    } catch (e) {
     // print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
      required String title,
    }
  ) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
// Row Count
  static Future <int> getRowCount() async {
    if (_userSheet == null) return 0;
    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  } 
// Get All Data
  static Future<List<User>> getAll() async {
    if (_userSheet == null) return <User>[];
    final showAll = await _userSheet!.values.map.allRows();
    return showAll == null ? <User>[] : showAll.map(User.formJson).toList();
    
  }
// Get Data by ID
  static Future<User?> getById(int id, ) async {
    if (_userSheet == null) return null;

    final byId = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    // final byName = await _userSheet!.values.map.rowByKey(name,fromColumn: 2);

    return byId == null ? null : User.formJson(byId);
    // if(byId.isNotEmpty)
    // final idRow = byId.first.rowIndex;
    
    // final nameRow = byName.lastRow();

    // if (idRow == nameRow){
    //   return User.formJson(byId);
    // } 

  }
// Signup
// Row Count
  static Future <int> rowCountSignup() async {
    if (_signupSheet == null) return 0;
    final lastRow = await _signupSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  } 
// insert signup data
  static Future insertSignup(List< Map < String, dynamic >> rowList) async {
    if(_signupSheet == null) return;
    _signupSheet!.values.map.appendRows(rowList);
  }

// insert data
  static Future insert(List< Map <String, dynamic>> rowList) async {
    if (_userSheet == null) return;
    _userSheet!.values.map.appendRows(rowList);
  }
  
  // UPDATE

  static Future<bool> update(int id,Map<String, dynamic> user) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.map.insertRowByKey(id, user);


  }

  // Update cell
  static Future<bool> updateCell({
    required int id,
    required String key,
    required dynamic value,
  }) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.insertValueByKeys(value, columnKey: key, rowKey: id);
  }

  // Delete
  static Future<bool> deleteRow(int id) async {
    if (_userSheet == null) return false;

    final index = await _userSheet!.values.rowIndexOf(id);

    if (index == -1) return false;

    return _userSheet!.deleteRow(index);
  }
}
