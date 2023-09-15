// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:rest_api_msl/screens/otp_verify.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phonecontroller = TextEditingController();
  var phoneController ;
  
  Future generateOtp() async {
   phoneController = "+91${_phonecontroller.text}";

    print(_phonecontroller.text);
    print(phoneController);
    final PermissionStatus status = await Permission.sms.request();
    if (status.isGranted) {
      var url = Uri.parse(
        'http://202.88.234.86:3331/user-entry',
      );
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        'phone': phoneController,
      });
      var response = await http.post(
        url,
        body: body,
        headers: headers,
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final otp = json.decode(response.body);
        print(otp);
        print('inside status0');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP Generation Successful!'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              phoneNumber: phoneController,
            ),
          ),
        );
      } else {
        print('inside else part');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to Generate otp'),
          ),
        );
      }
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  child: Text(
                    'Mobile no.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: IntlPhoneField(
                  // countries: [],
                  invalidNumberMessage: 'Not a valid number',
                  initialCountryCode: 'IN',
                  dropdownIconPosition: IconPosition.trailing,
                  disableLengthCheck: true,
                  showCountryFlag: true,
                  keyboardType: TextInputType.phone,
                  controller: _phonecontroller,
                  // validator: (value) {
                  //   if (value!.isValidNumber()) {
                  //     return "Enter a Valid Number";
                  //   }
                  //   return null;
                  // },
                  // onChanged: (phone) => print(phone.completeNumber),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 49,
              ),
              ElevatedButton(
                onPressed: generateOtp,

                // onPressed: () {
                //   _formKey.currentState?.validate();
                // },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(315, 46),
                ),
                child: const Text(
                  'LOGIN/SIGNUP',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
