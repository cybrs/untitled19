import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E5E6),
      appBar: AppBar(
        backgroundColor: Color(0xffE4E5E6),
        centerTitle: true,
        elevation: 0,
        title: Text("Privacy & Security", style: TextStyle(
            color: Colors.black
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height:100,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                         ListView(
                            children: [
                              ListTile(
                                leading: Icon(Icons.file_copy_outlined),
                                title: Text('Account Details'),
                                onTap: (){
                                  setState(() {

                                  });
                                },
                              ),
                            ],
                         ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
