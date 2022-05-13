import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gram_villa_latest/screens/dashboard/dashboard_screen.dart';
import 'package:gram_villa_latest/screens/otp/phone_screen.dart';
import 'package:gram_villa_latest/service/auth_service.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/widgets/show_snackbar.dart';
import 'dart:async';
import 'package:pinput/pin_put/pin_put.dart';

import '../../Constants.dart';

class Verification extends StatefulWidget {
  String phoneNumber;
  String verificationId;
  int? resendingToken;

  Verification(
      {Key? key,
      required this.phoneNumber,
      required this.verificationId,
      this.resendingToken})
      : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool _disableResend = false;
  bool _isVerified = false;
  bool _isLoading = false;
  final _pinPutController = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> resend() async {
    setState(() {
      _disableResend = true;
    });

    FirebaseAuth.instance.verifyPhoneNumber(
        forceResendingToken: widget.resendingToken,
        phoneNumber: widget.phoneNumber,
        timeout: const Duration(seconds: 10),
        verificationCompleted: (phoneAuthCredential) async {
          print('------- verificationCompleted');
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
            _isLoading = false;
          });
          print('-------- verificationFailed' + verificationFailed.code);
          ShowSnackbar.showSnackbar(
              'Verification failed. Please try again!', scaffoldMessengerKey);
        },
        codeSent: (verificationId, resendingToken) async {
          widget.verificationId = verificationId;
          widget.resendingToken = resendingToken;
          print('--------- codeSent with verification id = ' +
              verificationId +
              "  with resending token = " +
              resendingToken.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          print('------  codeAutoRetrievalTimeout');
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(5.0),
    );

    final _pinPutFocusNode = FocusNode();

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
                padding: paddingScreen,
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        child: Image.asset(
                          'assets/images/verify_otp.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      FadeInDown(
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            "Verification",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.grey.shade900),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeInDown(
                        delay: Duration(milliseconds: 500),
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          "Please enter the 4 digit code sent to " +
                              widget.phoneNumber,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Verification Code Input
                      FadeInDown(
                        delay: Duration(milliseconds: 600),
                        duration: Duration(milliseconds: 500),
                        child: PinPut(
                          autofocus: true,
                          validator: (s) {},
                          useNativeKeyboard: true,
                          autovalidateMode: AutovalidateMode.always,
                          withCursor: true,
                          fieldsCount: 6,
                          fieldsAlignment: MainAxisAlignment.spaceAround,
                          textStyle: const TextStyle(
                              fontSize: 25.0, color: Colors.black),
                          //eachFieldMargin: EdgeInsets.all(0),
                          eachFieldWidth: 40.0,
                          eachFieldHeight: 50.0,
                          onSubmit: (String pin) {
                            submitOTP();
                          },
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          submittedFieldDecoration: pinPutDecoration,
                          selectedFieldDecoration: pinPutDecoration.copyWith(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: const Color.fromRGBO(160, 215, 220, 1),
                            ),
                          ),
                          followingFieldDecoration: pinPutDecoration,
                          pinAnimationType: PinAnimationType.scale,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeInDown(
                        delay: Duration(milliseconds: 700),
                        duration: Duration(milliseconds: 500),
                        child: _disableResend
                            ? Spacer()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Didn't receive OTP?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade500),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        resend();
                                      },
                                      child: Text(
                                        "Resend",
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ))
                                ],
                              ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      FadeInDown(
                        delay: Duration(milliseconds: 800),
                        duration: Duration(milliseconds: 500),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: submitOTP,
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: buttonPadding,
                          child: _isLoading
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    color: Colors.black,
                                    strokeWidth: 3,
                                  ),
                                )
                              : _isVerified
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : Text(
                                      "Verify",
                                      style: TextStyle(color: Colors.white),
                                    ),
                        ),
                      )
                    ],
                  ),
                )),
          )),
    );
  }

  Future<void> submitOTP() async {
    String otpCode = _pinPutController.text;

    if (otpCode.length < 6) {
      ShowSnackbar.showSnackbar(
          'OTP should be 6 digits.', scaffoldMessengerKey);
    }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otpCode);
    try {
      await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);
      await AuthService().phoneSignIn();

      setState(() {
        _isVerified = true;
        _isLoading = false;
      });

      print("---------- signInMethod = " + credential.signInMethod);
      print("---------- phoneNumber = " +
          FirebaseAuth.instance.currentUser!.phoneNumber.toString());
      print("---------- uid = " + FirebaseAuth.instance.currentUser!.uid);
      print("---------- displayName = " +
          FirebaseAuth.instance.currentUser!.displayName.toString());
      print("---------- email = " +
          FirebaseAuth.instance.currentUser!.email.toString());

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DashboardScreen();
      }));
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-credential":
        case "invalid-verification-code":
          ShowSnackbar.showSnackbar(
              "Invalid OTP. Please try again!", scaffoldMessengerKey);
          break;
        case "provider-already-linked":
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return DashboardScreen();
          }));
          break;
        default:
          ShowSnackbar.showSnackbar(
              "Something went wrong. Please try again!", scaffoldMessengerKey);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return VerifyPhoneScreen();
          }));
          break;
      }
    }
  }
}
