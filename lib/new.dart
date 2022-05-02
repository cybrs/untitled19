import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'home.dart';
import 'login_page.dart';


class TabView extends StatefulWidget {


  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  int _counter = 0;

  void confirm() {
    setState(() {
      _counter++;
    });
  }

  final _formKey = GlobalKey<FormState>();
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
          backgroundColor: Color(0xffE4E5E6),//E0EEEE
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xffE4E5E6),
            centerTitle: true,
            elevation: 0,
            title: Text("Create New Account", style: TextStyle(
                color: Colors.black
            ),
            ),
            actions: <Widget>[
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert,color: Colors.black),
          color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text("Logout")
                ],
              )),
            ],
            onSelected: (item) => SelectedItem(context, item),
          ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.grey.shade300,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0,
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
                            text: 'Shop',

                          ),
                          Tab(
                            text: 'Personal',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
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
                                    Text("Shop Name", style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.blueGrey),),
                                    SizedBox(height: 15,),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Shop Name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Enter Shop Name",
                                        hintStyle: TextStyle(fontSize: 15.0,),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                              5),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.blueGrey),
                                    ),
                                    SizedBox(height: 20,),
                                    Text("Shop Address(Optional)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.blueGrey),),
                                    SizedBox(height: 15,),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Street text';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Street",
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                              5),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 157,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter City';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "City",
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius
                                                    .circular(5),
                                              ),
                                              contentPadding: EdgeInsets
                                                  .symmetric(
                                                  vertical: 10, horizontal: 10),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 60,
                                          width: 157,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter Pincode';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "PinCode",
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius
                                                    .circular(5),
                                              ),
                                              contentPadding: EdgeInsets
                                                  .symmetric(
                                                  vertical: 10, horizontal: 10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter State';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "State",
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius
                                                    .circular(5),
                                              ),
                                              contentPadding: EdgeInsets
                                                  .symmetric(
                                                  vertical: 10, horizontal: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 45,
                                      child: ElevatedButton(
                                        child: isLoading? Row(
                                          mainAxisAlignment: MainAxisAlignment.center ,
                                          children: const [
                                            Text('Loading...',style: TextStyle(fontSize: 18),),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CircularProgressIndicator(color:Colors.white),
                                          ],
                                        ): const Text('Create Shop Account',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                        style: ElevatedButton.styleFrom(
                                          // minimumSize: Size(400, 45),
                                          primary: Color(0xff007FFF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // <-- Radius
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          Future.delayed(Duration(seconds: 6),(){
                                            setState(() {
                                              isLoading = false;
                                            });
                                          });
                                          if (_formKey.currentState!.validate())
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()));
                                        },
                                      ),
                                    ),
                                   ]
                              ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("First Name", style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.blueGrey),),
                                    SizedBox(height: 15,),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter First Name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                              5),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Text("Last Name", style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.blueGrey),),
                                    SizedBox(height: 15,),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Last Name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                              5),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10,right: 10),
                                        width: MediaQuery.of(context).size.width,
                                        height: 45,
                                        child: ElevatedButton(
                                          child: isLoading? Row(
                                            mainAxisAlignment: MainAxisAlignment.center ,
                                            children: const [
                                              Text('Loading...',style: TextStyle(fontSize: 18),),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CircularProgressIndicator(color:Colors.white),
                                            ],
                                          ): const Text('Create Personal Account',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          style: ElevatedButton.styleFrom(
                                            // minimumSize: Size(400, 45),
                                            primary: Color(0xff007FFF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10), // <-- Radius
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            Future.delayed(Duration(seconds: 6),(){
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                            if (_formKey.currentState!.validate())
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home()));
                                          },
                                        ),
                                      ),
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

void SelectedItem(BuildContext context, item) {
  switch (item) {
    case 0:
      print("User Logged out");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
      break;
  }
}

