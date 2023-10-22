import "package:connectivity/connectivity.dart";
import "package:flutter/material.dart";
import "package:myfirst_flutter_project/bottom_navigator.dart";
import "package:myfirst_flutter_project/login_screen.dart";
import "package:myfirst_flutter_project/method.dart";
import "package:myfirst_flutter_project/update_screen.dart";
import "package:myfirst_flutter_project/user_fields.dart";
import "package:myfirst_flutter_project/user_sheet_api.dart";
import "package:share/share.dart";


class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> userList = [];
  final dates = DateTime.now();
  bool internet = false;

  getUser() async {
    var connectivityResult = await
      Connectivity().checkConnectivity();
      if(connectivityResult == ConnectivityResult.none){
        internet = true;
      }else{
        internet = false;
      try {
      final users = await UserSheetApi.getAll();
      setState(() {
        userList = users;
        
      });
    } catch (e) {
      setState(() {
  
      });
    }
    }
    
  }
  bool isToday(String time){
  final now = DateTime.now();
  final today = DateTime(now.year,now.month,now.day + 2);
  final format = dateformat(time);
  return format.isAtSameMomentAs(today);
  }
  @override
  void initState() {
  
    super.initState();
    getUser();
  }
  void refreshpage(){
    getUser();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        backgroundColor: Colors.blue,
        actions: [IconButton(onPressed: refreshpage, icon: const Icon(Icons.refresh))],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(50.0),
      //   child: Column(
      //     children: [
      //       InkWell(
      //         onTap: () {
      //           Navigator.pushNamed(context, FormScreen.id);
      //         },
      //         child: Container(
      //           height: 50,
      //           width: 300,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: Colors.blue,
      //           ),
      //           child: const Center(child: Text('Enter Data',
      //           style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),)),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       InkWell (
      //         onTap:() {
      //           Navigator.pushNamed(context, DisplayData.id);
      //         },
      //         child: Container(
      //           height: 50,
      //           width: 300,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: Colors.blue),
      //           child: const Center(child: Text('Client Info',
      //           style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),),)
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       InkWell(
      //         onTap: (){
      //           Navigator.pushNamed(context, SearchScreen.id);
      //         },
      //         child: Container(
      //           height: 50,
      //           width: 300,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: Colors.blue,
      //           ),
      //           child: const Center(child: Text('Search',
      //           style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),)),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage('images/IMG_20230814_230618_015.jpg'),
                ),
                accountName: Text('Saqlain Asif'),
                accountEmail: Text('saqlain.asif3344@gmail.com')),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, BottomNavigation.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update Client Info'),
              onTap: () {
                Navigator.pushNamed(context, UpdateScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Share.share('Check out this awesome app!');
              },

            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                Navigator.pushNamed(context, LogIn.id);
              },
            )
          ],
        ),
      ),
      body: SafeArea(child: Column(children: [
        if(internet)
        const InternetError(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(5, 5),
                  blurRadius: 10,

                )
              ]
            ), child: const Center(child: Text('WELCOME', style: TextStyle(color: Colors.red,fontSize: 40,fontWeight: FontWeight.bold),))),
        ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                      offset: Offset(0,10),
                      blurRadius: 20,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index){
                      final rowData = userList[index];
                      final dates = isToday(rowData.previousDate);
                      if(dates){
                        return Padding(
                          padding: const EdgeInsets.only(left: 6 , right: 6, top: 6,bottom: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey,
                              width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                            leading: const Image(height :50, width: 50, image: AssetImage('images/lawyer.png')),
                            title: Text(rowData.name),
                            subtitle: Text(rowData.phone),
                            trailing: Text(date(rowData.nextAppearance)),
                                        ),
                          ),
                        );
                      }else{
                         return Container(); 
                         //for text
                        //  ListTile(
                        //   title: Text(date(rowData.previousDate)),
                        //  );
                      }
                      
                    },),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 140.0),
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0,10),
                        blurRadius: 20,
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(child: Text('Coming Soon!',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: SingleChildScrollView(
        //     child: DataTable(
        //       columns: const [
        //   DataColumn(label: Text('Name')),
        //   DataColumn(label: Text('Phone Number')),
        //   DataColumn(label: Text('Next Appearance')),
        //       ],
              
        //       rows: userList.map((data){
        //   return DataRow(
            
        //     cells: 
        //   [
        //     DataCell(Text(data.name)),
        //     DataCell(Text(data.phone)),
        //     DataCell(Text(date(data.nextAppearance))),
        //   ]);
        //       }).toList(),
        //   ),),
        // ),
      
    
  
      ]),),
    );
  }
}


// bool isTomorrow(DateTime date){
//   final now = DateTime.now();
//   final tomorrow = DateTime(now.year, now.month,now.day + 1);
//   return date.isAtSameMomentAs(tomorrow);
  
// }
// bool isDayAfterTomorrow(DateTime date){
//   final now = DateTime.now();
//   final dayAfterTomorrow = DateTime(now.year, now.month, now.day +2 );
//   return date.isAtSameMomentAs(dayAfterTomorrow);
// }