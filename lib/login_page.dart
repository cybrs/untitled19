import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled19/Customshape.dart';
import 'Welcome.dart';
import 'new.dart';

enum MobileVerificationState{
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}


class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = '';

  bool showLoading = false;

  get async => null;

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async{

    setState(() {
      showLoading = true;
    });

    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });
      if(authCredential.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TabView(),));
      }
    } on FirebaseAuthException catch (e) {

      setState(() {
        showLoading = false;
      });
      _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  getMobileFormWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E5E6),
      resizeToAvoidBottomInset:true,
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff007FFF),
            child: Center(child: Text("",style: TextStyle(fontSize: 20,color: Colors.white),)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xfff7f6fb),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/number.png',
                    width: 240,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Registration',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add your phone number. we'll send you a verification code so we know you're real",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Enter your number",
                    hintStyle: TextStyle(fontSize: 15.0,),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                          5),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: ()  async{

                      setState(() {
                        showLoading = true;
                      });

                      await _auth.verifyPhoneNumber(
                          phoneNumber: phoneController.text,
                          verificationCompleted: (phoneAuthCredential) async{
                            setState(() {
                              showLoading = false;
                            });
                            //signInWithPhoneAuthCredential(phoneAuthCredential);
                          },
                          verificationFailed: (verificationFailed) async{

                            setState(() {
                              showLoading = false;
                            });

                            _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(verificationFailed.message.toString())));
                          },
                          codeSent: (verificationId, resendingToken) async{
                            setState(() {
                              showLoading = false;
                              currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                              this.verificationId = verificationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async{

                          }
                      );
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff007FFF),),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Send',
                        style: TextStyle(fontSize: 16),
                      ),
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


  // class Customshape extends CustomClipper<Path>{
  // @override
  // Path getClip(Size size) {
  // double height = size.height;
  // double width = size.width;
  // var path = Path();
  // path.lineTo(0, height-50);
  // path.quadraticBezierTo(width/2, height, width, height-50);
  // path.lineTo(width, 0);
  // path.close();
  // return path;
  // }
  // @override
  // bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
  // // TODO: implement shouldReclip
  // return true;
  // }
  // }


  getOtpFormWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff007FFF),
            child: Center(child: Text("Enter your Otp",style: TextStyle(fontSize: 20,color: Colors.white),)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 80),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/login.jpg',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Verification',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                    hintText: "Enter Otp Number",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                          5),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: ()  async{
                      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);

                      signInWithPhoneAuthCredential(phoneAuthCredential);

                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff007FFF),),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Verify',
                        style: TextStyle(fontSize: 16),
                      ),
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


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: showLoading ? Center(child: CircularProgressIndicator(),) : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE ?
      getMobileFormWidget(context) :
      getOtpFormWidget(context),
    );
  }
}