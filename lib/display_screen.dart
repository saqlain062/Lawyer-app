
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:myfirst_flutter_project/method.dart';
import 'package:myfirst_flutter_project/user_fields.dart';
import 'package:myfirst_flutter_project/user_sheet_api.dart';



class DisplayData extends StatefulWidget {
  static const String id = 'display_screen';
  
  const DisplayData({
    super.key,
    });

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  List<User> userList = [];
  bool isLoading = false;
  bool internet = false;
  bool elseError = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }
  void checkinternet(){
    setState(() {
      isLoading = false;
      internet = true;
    });
  }

  getUser() async {
    var connectivityResult = await
      Connectivity().checkConnectivity();
      if(connectivityResult == ConnectivityResult.none){
        checkinternet();
      }else{
      try {
      final users = await UserSheetApi.getAll();
      setState(() {
        userList = users;
        isLoading = false;
        internet = false;
      });
    } catch (e) {
      setState(() {
        elseError = true;
      });
    }
    }
    
  }
  void refreshData(){
    setState(() {
    });
    isLoading = true;
    getUser();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Information'),
      actions: [
        IconButton(onPressed: refreshData, icon: const Icon(Icons.refresh))
      ],
      ),
      body: 
      isLoading ? const Center(child: CircularProgressIndicator())  :
      internet ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InternetError()
          ],
        ),
      ) : elseError ? const ElseError() : 
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('List Number')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Phone Number')),
        DataColumn(label: Text('Previous Date')),
        DataColumn(label: Text('Next Appearance')),
        DataColumn(label: Text('Next Action'))
      ],
      rows: userList.map((data){
        return DataRow(
          cells: 
        [
          DataCell(Text(data.id.toString())),
          DataCell(Text(data.serial.toString())),
          DataCell(Text(data.name)),
          DataCell(Text(data.phone)),
          DataCell(Text(date(data.previousDate))),
          DataCell(Text(date(data.nextAppearance))),
          DataCell(Text(data.nextAction))
        ]);
      }).toList(),
        ),),
      ),
    );
  }
}
