import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:share/share.dart';
import 'package:untitled19/ResetApp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Privacy.dart';
import 'RatingDialog.dart';
import 'FeedbackDialog.dart';

enum Txn {
  received,
  paid
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentTab = 0;
  final List<Widget> screens =  [
    Dashboard(),
    Explore(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget cureentScreen = Dashboard();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E5E6),
      body: PageStorage(
        child: cureentScreen,
        bucket: bucket,
      ),
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.add),backgroundColor: Color(0xff007FFF),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => float(),));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: (){
                        setState(() {

                          cureentScreen = Dashboard();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_filled,
                            color: currentTab == 0 ? Color(0xff007FFF) : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(color: currentTab == 0? Color(0xff007FFF) : Colors.grey
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,

                    ),
                    //Right side
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: (){
                            setState(() {

                              cureentScreen = Explore();
                              currentTab =3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.explore,
                                color: currentTab == 3 ? Color(0xff007FFF): Colors.grey,
                              ),
                              Text(
                                'Transations',
                                style: TextStyle(color: currentTab == 3? Color(0xff007FFF) : Colors.grey
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}





class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

double sum = 0;
class _DashboardState extends State<Dashboard> {

  // final Stream<QuerySnapshot> _usersStream =
  // FirebaseFirestore.instance.collection('notes').snapshots();

  Txn activeTxn = Txn.paid;
  @override
  Widget build(BuildContext context) {
    var services;
    return Scaffold(
      backgroundColor: Color(0xffE4E5E6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffE4E5E6),
        centerTitle: true,
        elevation: 0,
        title: Text('Dashbord', style: TextStyle(
            color: Colors.black
        ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => setting()));
              // do something
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        activeTxn = Txn.paid;
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: activeTxn == Txn.paid? Color(0xFF98FB98): Color(0xFFf0fff0),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0,2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('To Be Received',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text('\u{20B9}',style: TextStyle(fontSize: 25),textAlign: TextAlign.left,),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Text('$sum',style: TextStyle(fontSize: 25),textAlign: TextAlign.left,))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        activeTxn = Txn.received;
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: activeTxn == Txn.received? Color(0xFFf88379): Color(0xFFf0fff0),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0,2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('To Be Paid',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                            SizedBox(
                             height: 15,
                            ),
                            Row(
                              children: [
                                Text('\u{20B9}',style: TextStyle(fontSize: 25),textAlign: TextAlign.left,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('0.00',style: TextStyle(fontSize: 25),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              indent: 2,
              endIndent: 2,
              color: Colors.blueGrey,
            ),
            SizedBox(
              height: 20,
            ),
                // Container(
                //   height: MediaQuery.of(context).copyWith().size.height,
                //   color: Colors.white38,
                //   child: StreamBuilder(
                //     stream: _usersStream,
                //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //       if (snapshot.hasError) {
                //         return Text("something is wrong");
                //       }
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       return Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //
                //         ),
                //         child: ListView.builder(
                //           itemCount: snapshot.data!.docs.length,
                //           itemBuilder: (_, index) {
                //             return GestureDetector(
                //               onTap: () {
                //               },
                //               child: Column(
                //                 children: [
                //                   SizedBox(
                //                     height: 4,
                //                   ),
                //                   Padding(
                //                     padding: EdgeInsets.only(left: 15,right: 15,
                //                     ),
                //                     child: Container(
                //                       height: 80,
                //
                //                       color: Colors.black
                //                           .withOpacity(0.2),
                //
                //                       child: ListTile(
                //
                //                         shape: RoundedRectangleBorder(
                //
                //                         ),
                //                         title: Text(
                //                           snapshot.data!.docChanges[index].doc['rupee'],
                //                           style: TextStyle(
                //                             fontSize: 20,
                //                           ),
                //                         ),
                //                         subtitle: Text(
                //                           snapshot.data!.docChanges[index].doc['description'],
                //                           style: TextStyle(
                //                             fontSize: 15,
                //                           ),
                //                         ),
                //                         contentPadding: EdgeInsets.symmetric(
                //                           vertical: 12,
                //                           horizontal: 16,
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             );
                //           },
                //         ),
                //       );
                //     },
                //   ),
                // ),
          ],
        ),
      ),
    );
  }
}


class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E5E6),
      appBar: AppBar(
        centerTitle: true,
      iconTheme: IconThemeData(
      color: Colors.black,
      ),
    automaticallyImplyLeading: true,
        backgroundColor: Color(0xffE4E5E6),
        elevation: 0,
        title: Text('Setting', style: TextStyle(
            color: Colors.black
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.file_copy_outlined),
                title: Text('Account Details'),
                onTap: (){
                  setState(() {

                  });
                },
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.loop),
                title: Text('Switch Account'),
                onTap: (){
                  setState(() {

                  });
                },
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: Text('Privacy & Security'),
                onTap: (){
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Privacy()),
                        );
                  });
                },
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.brush),
                title: Text('Theme'),
                onTap: (){
                  setState(() {

                  });
                },
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.refresh),
                title: Text('Reset App Data'),
                onTap: (){
                  setState(() {
                    showDialog(
                        context: context, builder:
                        (context) => const ResetApp());

                  });
                },
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.feedback_outlined),
                title: Text('Send Feedback'),
                onTap: ()
                  {
                    showDialog(
                        context: context, builder:
                        (context) => const FeedbackDialog());
                  }
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share to your friends'),
                onTap: (){
                  setState(() {
                    Share.share(
                        'check out my website https://protocoderspoint.com/');
                  });
                },
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.star_half_outlined),
                title: Text('Give Rating'),

                onTap: () async {
                  int stars = await showDialog(
                      context: context,
                      builder: (_) => RatingDialog()
                  );

                  if(stars == null) return;

                  print('Selected rate stars: $stars');
                },
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('App Version'),
                subtitle: Text('1.0.0'),
                onTap: (){
                  setState(() {

                  });
                },
              ),
              const Divider(
                height: 9,
                thickness: 0.5,
                indent: 2,
                endIndent: 2,
                color: Colors.grey,
              ),
            ]
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor:  Color(0xff007FFF) ,
              icon: Icon(Icons.logout,color: Colors.red,),
              label: Text("Log Out"),
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [


            // ElevatedButton(
            //   child: Text('Log Out',style: TextStyle(color: Colors.white,fontSize: 18)),
            //   style: ElevatedButton.styleFrom(
            //
            //     minimumSize: Size(200,50),
            //     primary: Colors.redAccent,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12), // <-- Radius
            //     ),
            //   ),
            //   onPressed: (){},
            // ),
        //   ],
        // ),
      ],
    );
  }
}











//Transaction List




class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // final Stream<QuerySnapshot> _usersStream =
  // FirebaseFirestore.instance.collection('notes').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E5E6),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffE4E5E6),

        title: Text('Transaction List',style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.picture_as_pdf_rounded,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Pdf()));
              // do something
            },
          )
        ],

      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                  indicatorWeight: 3.0,
                  tabs:
              [
                Tab(child: Text('ALL',style: TextStyle(color: Colors.blueGrey),),),
                Tab(child: Text('PAID',style: TextStyle(color: Colors.blueGrey),),),
                Tab(child: Text('RECEIVED',style: TextStyle(color: Colors.blueGrey),),),
              ]),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              indent: 2,
              endIndent: 2,
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  Container(
                    child: Text("User Body"),
                    // child: StreamBuilder(
                    //   stream: _usersStream,
                    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //     if (snapshot.hasError) {
                    //       return Text("something is wrong");
                    //     }
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //     return Container(
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       child: ListView.builder(
                    //         itemCount: snapshot.data!.docs.length,
                    //         itemBuilder: (_, index) {
                    //           return GestureDetector(
                    //             onTap: () {
                    //             },
                    //             child: Column(
                    //               children: [
                    //                 SizedBox(
                    //                   height: 4,
                    //                 ),
                    //                 Padding(
                    //                   padding: EdgeInsets.only(
                    //                     left: 3,
                    //                     right: 3,
                    //                   ),
                    //                   child: ListTile(
                    //                     shape: RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.circular(10),
                    //                       side: BorderSide(
                    //                         color: Colors.black,
                    //                       ),
                    //                     ),
                    //                     title: Text(
                    //                       snapshot.data!.docChanges[index].doc['rupee'],
                    //                       style: TextStyle(
                    //                         fontSize: 20,
                    //                       ),
                    //                     ),
                    //                     subtitle: Text(
                    //                       snapshot.data!.docChanges[index].doc['description'],
                    //                       style: TextStyle(
                    //                         fontSize: 15,
                    //                       ),
                    //                     ),
                    //                     contentPadding: EdgeInsets.symmetric(
                    //                       vertical: 12,
                    //                       horizontal: 16,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),

                  ),
                  Container(
                    child: Text("User Body"),
                  ),
                  // Container(
                  //   child: StreamBuilder(
                  //       stream: _usersStream,
                  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //         if (snapshot.hasError) {
                  //           return Text("something is wrong");
                  //         }
                  //         if (snapshot.connectionState == ConnectionState.waiting) {
                  //           return Center(
                  //             child: CircularProgressIndicator(),
                  //           );
                  //         }
                  //         return Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(12),
                  //
                  //           ),
                  //           child: ListView.builder(
                  //             itemCount: snapshot.data!.docs.length,
                  //             itemBuilder: (_, index) {
                  //               return GestureDetector(
                  //                 onTap: () {
                  //                 },
                  //                 child: Column(
                  //                   children: [
                  //                     SizedBox(
                  //                       height: 4,
                  //                     ),
                  //                     Padding(
                  //                       padding: EdgeInsets.only(left: 15,right: 15,
                  //                       ),
                  //                       child: Container(
                  //                         height: 80,
                  //
                  //                        color: Colors.black
                  //                             .withOpacity(0.2),
                  //
                  //                         child: ListTile(
                  //
                  //                           shape: RoundedRectangleBorder(
                  //
                  //                           ),
                  //                           title: Text(
                  //                             snapshot.data!.docChanges[index].doc['rupee'],
                  //                             style: TextStyle(
                  //                               fontSize: 20,
                  //                             ),
                  //                           ),
                  //                           subtitle: Text(
                  //                             snapshot.data!.docChanges[index].doc['description'],
                  //                             style: TextStyle(
                  //                               fontSize: 15,
                  //                             ),
                  //                           ),
                  //                           contentPadding: EdgeInsets.symmetric(
                  //                             vertical: 12,
                  //                             horizontal: 16,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  //         );
                  //       },
                  //     ),
                  // ),
                  Container(
                    child: Text("User Body"),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// PDF


class Pdf extends StatefulWidget {
 Pdf({Key? key}) : super(key: key);
  @override
  State<Pdf> createState() => _PdfState();
}
class _PdfState extends State<Pdf> {
  GlobalKey<FormState> FormKey= GlobalKey<FormState>();
  String dropdownValue = 'Today';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('All Reports', style: TextStyle(
        color: Colors.white
    ),
    ),
    ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 355,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date Range"),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down_outlined, ),
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 30,color: Colors.transparent)
                    )
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Today','This Week','This Month','This Year']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// add TXN


class float extends StatefulWidget {
  const float({Key? key}) : super(key: key);

  @override
  State<float> createState() => _floatState();
}

class _floatState extends State<float> with SingleTickerProviderStateMixin {
  TextEditingController rupee = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController name = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE4E5E6),
        appBar: AppBar(
        iconTheme: IconThemeData(
        color: Colors.black,
        ),
        elevation: 0,
          backgroundColor: Color(0xffE4E5E6),
         
          title: Text("Add Transaction",style: TextStyle(
              color: Colors.black
          ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        5.0,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                        color: Color(0xff007FFF),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey.shade900,
                      tabs: [
                        Tab(
                          text: 'I Recevived',

                        ),
                        Tab(
                          text: 'I paid',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  child: Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 157,
                                        child: TextField(
                                          controller: rupee,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                            hintText: "\u{20B9}",hintStyle: TextStyle(color: Colors.green,fontSize: 20),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      // Text('$Received'),
                                      GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: Container(
                                          height: 50,
                                          width: 157,
                                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.calendar_today,  color: Color(0xff007FFF),),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text("${selectedDate.toLocal()}".split(' ')[0]),
                                              ]
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 100,
                                    width:325,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: description,
                                          decoration: InputDecoration(
                                            hintText: "Type your description here",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:
                                    TextFormField(
                                      controller: name,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.person_outline_rounded, color: Color(0xff007FFF),),
                                        hintText: "Customer name",
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        suffixIcon: GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));

                                            },
                                            child: const Icon(Icons.contacts,  color: Color(0xff007FFF),)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FloatingActionButton.extended(
                                        onPressed: () {

                                         setState(() {
                                         sum = double.parse(rupee.text) + sum;

                                         });

                                          Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (_) =>const Dashboard()));
                                        },
                                        backgroundColor:  Color(0xff007FFF) ,
                                        icon: Icon(Icons.save),
                                        label: Text("Save"),
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.symmetric(vertical: 12),
                                  //       child: ElevatedButton(
                                  //         child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 18)),
                                  //         style: ElevatedButton.styleFrom(
                                  //           minimumSize: Size(100,50),
                                  //           primary: Colors.blueGrey,
                                  //           shape: RoundedRectangleBorder(
                                  //             borderRadius: BorderRadius.circular(10), // <-- Radius
                                  //           ),
                                  //         ),
                                  //         onPressed: (){
                                  //           setState(() {
                                  //             double sum = 0;
                                  //             sum = double.parse(rupee.text) + sum;
                                  //             Received = sum.toString();
                                  //           });
                                  //           // ref.add({
                                  //           //   'rupee': rupee.text,
                                  //           //   'description': description.text,
                                  //           //   'name': name.text,
                                  //           //
                                  //           // }).whenComplete(() {
                                  //           //   Navigator.pushReplacement(
                                  //           //       context, MaterialPageRoute(builder: (_) =>const Explore()));
                                  //           // });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                ],
                              ),
                            ),
                          ),




                          // Second Tab


                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 157,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            hintText: "\u{20B9}",hintStyle: TextStyle(color: Colors.red,fontSize: 20),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: Container(
                                          height: 50,
                                          width: 157,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.calendar_today, color: Color(0xff007FFF)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("${selectedDate.toLocal()}".split(' ')[0]),
                                              ]
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 100,
                                    width:325,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                            hintText: "Type your description here",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:
                                    TextFormField(
                                      controller: name,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.person_outline_rounded, color: Color(0xff007FFF),),
                                        hintText: "Customer name",
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        suffixIcon: GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));

                                            },
                                            child: const Icon(Icons.contacts, color: Color(0xff007FFF),)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FloatingActionButton.extended(
                                        onPressed: () {},
                                        backgroundColor:  Color(0xff007FFF) ,
                                        icon: Icon(Icons.save),
                                        label: Text("Save"),
                                      ),
                                    ],
                                  ),
                                  // ElevatedButton(
                                  //   child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 18)),
                                  //   style: ElevatedButton.styleFrom(
                                  //     minimumSize: Size(100,50),
                                  //     primary: Colors.blueGrey,
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10), // <-- Radius
                                  //     ),
                                  //   ),
                                  //   onPressed: (){
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// contact service

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  List<Contact>? contacts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }
  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts);
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "  Contacts  ",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: (contacts) == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
            itemCount: contacts!.length,
            itemBuilder: (BuildContext context, int index) {
            Uint8List? image = contacts![index].photo;
            String num = (contacts![index].phones.isNotEmpty) ? (contacts![index].phones.first.number) : "--";
            return ListTile(
                leading: (contacts![index].photo == null)
                    ? const CircleAvatar(child: Icon(Icons.person))
                    : CircleAvatar(backgroundImage: MemoryImage(image!)),
                title: Text(
                    "${contacts![index].name.first} ${contacts![index].name.last}"),
                subtitle: Text(num),
                onTap: () {
                  if (contacts![index].phones.isNotEmpty) {
                    launch('tel: ${num}');
                  }
                });
          },
        ));
  }
}
