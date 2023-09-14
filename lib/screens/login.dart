// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_msl/screens/otp_verify.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phonecontroller = TextEditingController();

  Future<void> generateOtp() async {
    final apiUrl = 'http://202.88.234.86:3331/user-entry';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final otp = response.body;
      print('Otp generated : $otp');
    } else {
      print('Failed to generate otp ${response.statusCode}');
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey();
  
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
                  invalidNumberMessage: 'Not a valid number',
                  initialCountryCode: 'IN',
                  dropdownIconPosition: IconPosition.trailing,
                  disableLengthCheck: true,
                  showCountryFlag: true,
                  keyboardType: TextInputType.phone,
                  controller: _phonecontroller,
                  onChanged: (phone) => print(phone.completeNumber),
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
                // onPressed: generateOtp

                onPressed: () {
                  _formKey.currentState?.validate();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpScreen(),
                    ),
                  );
                },

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
