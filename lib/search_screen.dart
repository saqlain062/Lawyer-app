
import 'package:connectivity/connectivity.dart';
import 'package:myfirst_flutter_project/bottom_navigator.dart';
import 'package:myfirst_flutter_project/method.dart';
import 'package:myfirst_flutter_project/user_sheet_api.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';

  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController controllerID = TextEditingController();
  late TextEditingController controllerSerialNo = TextEditingController();
  late TextEditingController controllerName = TextEditingController();
  late TextEditingController controllerPhone = TextEditingController();
  late TextEditingController controllerSearchid = TextEditingController();
  late TextEditingController controllerPrevious = TextEditingController();
  late TextEditingController controllerNextAppearance = TextEditingController();
  late TextEditingController controllerNextAction = TextEditingController();
  
  bool showSearchFields = false;
  bool notfound = false;
  bool isLoading = false;
  bool empty = false;
  bool delete = false;
  bool checkInternet = false;

  void checkinternet(){
    setState(() {
      checkInternet = true;
    });
  }
  void loading(){
    setState(() {
      isLoading = true;
    });
    search();
  }

  Future search() async {
    final searchText = controllerSearchid.text.trim();
    final searchid = int.tryParse(searchText);
    setState(() {
      checkInternet = false;
      notfound = false;
      empty = false;
      showSearchFields = false;
      delete = false;
      
    });
    if(searchText.isEmpty){
        setState(() {
        isLoading = false;
        empty = true;
      });
    }else{
      final user = await UserSheetApi.getById(searchid!);
      if (user != null ) {
        final id = user.id;
        final serial =  user.serial;
        final name =  user.name;
        final phone = user.phone;
        final previous = user.previousDate;
        final nextAppearance = user.nextAppearance;
        final nextAction = user.nextAction;
        setState(() {
          controllerID =TextEditingController(text: id.toString());
          controllerSerialNo = TextEditingController(text: serial.toString());
          controllerName = TextEditingController(text: name);
          controllerPhone = TextEditingController(text: phone);
          controllerPrevious = TextEditingController(text: date(previous));
          controllerNextAppearance = TextEditingController(text: date(nextAppearance));
          controllerNextAction = TextEditingController(text: nextAction);
          isLoading = false;
          showSearchFields = true;
        });
      }else{
        setState(() {
          isLoading = false;
          notfound = true;
        });
      }
    }
  }
  Future deleteData() async {
    final searchid = int.tryParse(controllerSearchid.text);
    if(searchid == null ){
      return;
    }
    await UserSheetApi.deleteRow(searchid);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search'), backgroundColor: Colors.lightBlue
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerSearchid,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Enter your ID',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                  if(isLoading)
                  const CircularProgressIndicator(),

                  ElevatedButton(
                    onPressed: () async {
                      var connectivityResult = await
                  Connectivity().checkConnectivity();
                  if(connectivityResult == ConnectivityResult.none){
                    checkinternet();
                  }else{
                    loading();
                    
                      
                  }
                    },
                    child: const Text('Search'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if(checkInternet)
                  const InternetError(),
                
                  if(showSearchFields)
                  Column(
                    children: [
                      TextFormField(
                        controller: controllerID,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(gapPadding: 4),
                          labelText: 'ID',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                            controller: controllerSerialNo,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(gapPadding: 4),
                              labelText: 'List Number',
                            ),
                          ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controllerName,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(gapPadding: 4),
                          labelText: 'Name',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controllerPhone,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(gapPadding: 4),
                          labelText: 'Phone Number',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                            controller: controllerPrevious,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(gapPadding: 4),
                              labelText: 'Previous Date',
                            ),
                          ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                            controller: controllerNextAppearance,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(gapPadding: 4),
                              labelText: 'Next Appearance',
                            ),
                          ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                            controller: controllerNextAction,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(gapPadding: 4),
                              labelText: 'Next Action',
                            ),
                          ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Do You want to Delete?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(onPressed:() async {
                               var connectivityResult = await
                  Connectivity().checkConnectivity();
                  if(connectivityResult == ConnectivityResult.none){
                    checkinternet();
                  }else{
                    deleteData();
                  }
                              
                              setState(() {
                                showSearchFields = false;
                                delete = true;
                                empty = false;
                                notfound = false;
                              });
                            }, child: const Text('Delete')),
                            ElevatedButton(onPressed:() {
                              Navigator.pushNamed(context, BottomNavigation.id);
                            }, child: const Text('Back'))
                          ],
                        ),
                      )
                    ],
                  ),
                  if(notfound)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_outlined, color: Colors.red,),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Not Found! Try Again', style: TextStyle(fontWeight: FontWeight.bold),)  
                    ],
                  ),
                  if(empty)
                  const EmptyField(),
                  if(delete)
                  const Column(
                    children: [
                      Text('Delete Successfully' ,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 30),),
                      Divider(
                        height: 30,
                        thickness: 10,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
