import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hair_salon/home_page.dart';
import 'package:hair_salon/number_login.dart';
import 'package:pinput/pinput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OTPVerification extends StatefulWidget {
  final String phonenumber;
  const OTPVerification({super.key, required this.phonenumber});

  @override
  State<OTPVerification> createState() => _nameState();
}

class _nameState extends State<OTPVerification> {
  var buttonpressed = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(0, 0, 0, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 225, 225, 225)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Color.fromARGB(255, 234, 234, 234),
      border: Border.all(color: Color.fromARGB(255, 210, 210, 210)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromARGB(255, 234, 234, 234),
      ),
    );
    var code = "";
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 160, height: 160),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "OTP Verification",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Enter OTP sent to ',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.phonenumber,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Did't receive the OTP",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Resend OTP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          setState(() {
                            buttonpressed = true;
                          });
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: NumberLogin.verify,
                                  smsCode: code);
                          await auth.signInWithCredential(credential);
                          final FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          DocumentSnapshot d = await FirebaseFirestore.instance
                              .collection('client')
                              .doc(widget.phonenumber)
                              .get();
                          if (!d.exists) {
                            await firestore
                                .collection('client')
                                .doc(widget.phonenumber)
                                .set({'variable': 0});
                            await firestore
                                .collection('client')
                                .doc(widget.phonenumber)
                                .collection('0')
                                .doc('0')
                                .set({
                              'Title': "No Video",
                              'Desc': "",
                              'Category': "Add a video to display",
                              'Address': "",
                              'path': "",
                              // ignore: avoid_print
                            }).onError((error, stackTrace) => print(error));
                          }
                          setState(() {
                            buttonpressed = false;
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(phonenumber: widget.phonenumber),
                            ),
                          );
                        } catch (e) {
                          // ignore: avoid_print
                          setState(() {
                            buttonpressed = false;
                          });
                          Fluttertoast.showToast(
                            msg: 'OTP Invalid',
                            backgroundColor: Colors.grey,
                          );
                          print("Wrong oTP");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Stack(
                        children: [
                          if(!buttonpressed)
                          const Text(
                            "Verify OTP",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          if(buttonpressed)
                          const SpinKitFadingFour(
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ],
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: const SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}
