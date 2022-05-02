import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:untitled19/new.dart';

import 'Welcome.dart';
import 'login_page.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      /* light theme settings */
    ),
    darkTheme: ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    ),


    home: AnimatedSplashScreen(
      splashIconSize: 280,
      splash: Image.asset("assets/rupee.png"),
      nextScreen: Welcome(),
    ),
  ));
}

class Initializer extends StatefulWidget {
  const Initializer({Key? key}) : super(key: key);

  @override
  State<Initializer> createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {

  late FirebaseAuth _auth;
  late User? _user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) : _user == null ? LoginPage() : TabView();
  }
}


// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:url_launcher/url_launcher.dart';
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const MyStatefulWidget(),
//       ),
//     );
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final ButtonStyle style =
//     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
//
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           GestureDetector(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
//
//             },
//             child: Container(
//               height: 50,
//               width: 250,
//               color: Colors.blue,
//               child: Text('Harsh'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
//   List<Contact>? contacts;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getContact();
//   }
//   void getContact() async {
//     if (await FlutterContacts.requestPermission()) {
//       contacts = await FlutterContacts.getContacts(
//           withProperties: true, withPhoto: true);
//       print(contacts);
//       setState(() {});
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "***  App Name  ***",
//             style: TextStyle(color: Colors.blue),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: (contacts) == null
//             ? Center(child: CircularProgressIndicator())
//             : ListView.builder(
//           itemCount: contacts!.length,
//           itemBuilder: (BuildContext context, int index) {
//             Uint8List? image = contacts![index].photo;
//             String num = (contacts![index].phones.isNotEmpty) ? (contacts![index].phones.first.number) : "--";
//             return ListTile(
//                 leading: (contacts![index].photo == null)
//                     ? const CircleAvatar(child: Icon(Icons.person))
//                     : CircleAvatar(backgroundImage: MemoryImage(image!)),
//                 title: Text(
//                     "${contacts![index].name.first} ${contacts![index].name.last}"),
//                 subtitle: Text(num),
//                 onTap: () {
//                   if (contacts![index].phones.isNotEmpty) {
//                     launch('tel: ${num}');
//                   }
//                 });
//           },
//         ));
//   }
// }