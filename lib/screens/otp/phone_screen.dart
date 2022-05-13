import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gram_villa_latest/screens/dashboard/dashboard_screen.dart';
import 'package:gram_villa_latest/screens/otp/verification_screen.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/widgets/show_snackbar.dart';

import '../../Constants.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({Key? key}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _isLoading = false;
  String? verificationId;
  int? resendingToken;
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: paddingScreen,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/phone_input.png',
                  fit: BoxFit.cover,
                  width: 200,
                ),
                SizedBox(
                  height: 50,
                ),
                FadeInDown(
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.grey.shade900),
                  ),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Enter your phone number to continue, we will send an OTP to verify.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 400),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black.withOpacity(0.13)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffeeeeee),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(fontSize: 18, letterSpacing: 1.5),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      onSubmitted: (String phoneNumber) {
                        submitPhoneNumber();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Text("+91 - "),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 600),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: submitPhoneNumber,
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
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Request OTP",
                            style: TextStyle(color: Colors.white),
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

  void submitPhoneNumber() {
    setState(() {
      _isLoading = true;
    });

    String phoneNumber = controller.text;
    if (isValidPhoneNumber(phoneNumber)) {
      this.phoneNumber = phoneNumber;
      initiateOTPGeneration(DEFAULT_DIALING_CODE + phoneNumber);
    } else {
      setState(() {
        _isLoading = false;
      });
      //showSnackbar('Invalid phone number. Try again!', scaffoldMessengerKey);
      ShowSnackbar.showSnackbar(
          'Invalid phone number. Try again!', scaffoldMessengerKey);
    }
  }

  void showSnackbar(String text) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: AppColors.secondaryColor,
      duration: Duration(seconds: 3),
    ));
  }

  bool isValidPhoneNumber(String phoneNumber) {
    if (phoneNumber.length != 10) {
      return false;
    }
    RegExp regExp = new RegExp(
      r"[0-9]+",
      caseSensitive: false,
      multiLine: false,
    );
    return regExp.hasMatch(phoneNumber);
  }

  Future<void> initiateOTPGeneration(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: (phoneAuthCredential) async {
          print('------- verificationCompleted');
          ShowSnackbar.showSnackbar(
              'Verification completed.', scaffoldMessengerKey);
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _isLoading = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return DashboardScreen();
              }),
            );
          });
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
            _isLoading = false;
          });
          print('-------- verificationFailed' + verificationFailed.code);
          ShowSnackbar.showSnackbar(
              'Verification failed. Please try again.', scaffoldMessengerKey);
        },
        codeSent: (verificationId, resendingToken) async {
          this.verificationId = verificationId;
          this.resendingToken = resendingToken;
          print('--------- codeSent with verification id = ' +
              verificationId +
              "  with resending token = " +
              resendingToken.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          print('------  codeAutoRetrievalTimeout');
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              _isLoading = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Verification(
                          phoneNumber: this.phoneNumber.toString(),
                          resendingToken: this.resendingToken,
                          verificationId: this.verificationId.toString(),
                        )));
          });
        });
  }
}
