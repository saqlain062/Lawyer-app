import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:myfirst_flutter_project/method.dart';
import 'package:myfirst_flutter_project/user_fields.dart';
import 'package:myfirst_flutter_project/user_sheet_api.dart';

class UpdateScreen extends StatefulWidget {
  static const String id = 'update_screen';

  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final formkey = GlobalKey<FormState>();
  late TextEditingController controllerSerialNo = TextEditingController();
  late TextEditingController controllerName = TextEditingController();
  late TextEditingController controllerPhone = TextEditingController();
  late TextEditingController controllerUpdateid = TextEditingController();
  late TextEditingController controllerPrevious = TextEditingController();
  late TextEditingController controllerNextAppearance = TextEditingController();
  late TextEditingController controllerNextAction = TextEditingController();
  bool internet = false;
  bool updated = false;
  bool showform = false;
  bool empty = false;
  bool notfound = false;
  bool searchfield = false;

  Future search() async {
    final searchText = controllerUpdateid.text.trim();
    if (searchText.isEmpty) {}
    final searchid = int.tryParse(searchText);
    if (searchid == null) {
      setState(() {
        empty = true;
        notfound = false;
      });
      return;
    }else{
    final user = await UserSheetApi.getById(searchid);
    if (user != null) {
      final id = user.id;
      final serial = user.serial;
      final name = user.name;
      final phone = user.phone;
      final previous = user.previousDate;
      final nextAppearance = user.nextAppearance;
      final nextAction = user.nextAction;
      setState(() {
        controllerUpdateid = TextEditingController(text: id.toString());
        controllerSerialNo = TextEditingController(text: serial.toString());
        controllerName = TextEditingController(text: name);
        controllerPhone = TextEditingController(text: phone);
        controllerPrevious = TextEditingController(text: date(previous));
        controllerNextAppearance = TextEditingController(text: date(nextAppearance));
        controllerNextAction = TextEditingController(text: nextAction);

        showform = true;
        searchfield = false;
        notfound = false;
      });
    }else{
      setState(() {
        notfound = true;
        empty = false;
        showform = false;
      });
    }

    }
    
  }

  void checkinternet() {
    setState(() {
      internet = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(searchfield)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                controller: controllerUpdateid,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    labelText: 'ID',
                                    hintText: '0-9',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black))),
                                validator: (value) {
                                  return checklist(value);
                                }),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                              height: 45,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    var connectivityResult =
                                        await Connectivity()
                                            .checkConnectivity();
                                    if (connectivityResult ==
                                        ConnectivityResult.none) {
                                      checkinternet();
                                    } else {
                                      search();
                                    }
                                  },
                                  child: const Text('Search')))
                        ],
                      ),
                      if (empty) const EmptyField(),
                      if (notfound) const NoFound(),
                      if (internet) const InternetError(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (showform)
                      Column(
                        children: [
                           const Text(
                          'Make change & Press Update',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: controllerSerialNo,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'List Number',
                              hintText: '0-9',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                          validator: (value) {
                            return checklist(value);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: controllerName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Saqlain Asif',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                          validator: (value) {
                            return checkname(value);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: controllerPhone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Phone No',
                              hintText: '0321-1234567',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                          validator: (value) {
                            return checknumber(value);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controllerPrevious,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            labelText: 'Previous Date',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Enter Previous Date'
                            : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controllerNextAppearance,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            labelText: 'Next Appearance',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Enter Next Appearance'
                            : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controllerNextAction,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Next Action',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Next Action'
                            : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(onPressed: () async {
                        var connectivityResult = await Connectivity().checkConnectivity();
                          if (connectivityResult == ConnectivityResult.none) {
                            checkinternet();
                          } else {
                           
                            final id = int.tryParse(controllerUpdateid.text);
                            if (id == null) {
                              return;
                            }
                            final form = formkey.currentState!;
                            final isValid = form.validate();
                            if (isValid) {
                              final user = User(id: int.tryParse(controllerSerialNo.text),
                              name: controllerName.text, phone: controllerPhone.text,
                              previousDate: controllerPrevious.text,
                              nextAppearance: controllerNextAppearance.text,
                              nextAction: controllerNextAction.text);
                              await UserSheetApi.update(id, user.toJson());
                              controllerName.clear();
                              controllerPhone.clear();
                              controllerSerialNo.clear();
                              controllerUpdateid.clear();
                              controllerNextAction.clear();
                              controllerNextAppearance.clear();
                              controllerPrevious.clear();
                              setState(() {
                                updated = false;
                                showform = false;
                                empty = false;
                              });
                            }
                          }
                        },
                        child: const Text('Update')),


                       
                    ],
                        ),
                      if (!updated)
                      Column(
                          children: [
                            const Text(
                              'Data Update Successfully',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
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
                            const Text(
                              'Do You Update One More',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          searchfield = true;
                                          updated = true;
                                        });
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('back'))
                                  ]),
                                  
                      ), ],
                            ),
                         
                    ],
                  ),
                ),
              ))),
    );
  }
}
