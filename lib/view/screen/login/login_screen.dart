import 'dart:convert';
import 'dart:ui';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ayurvedic_centre/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_sp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                        login,
                        fit: BoxFit.cover,
                      )),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black
                            .withOpacity(0), // Adjust the opacity as needed
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      logo,
                      width: 100, // Adjust the width as needed
                      height: 100, // Adjust the height as needed
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: Text(
                      'Login or register to book Your Appointments',
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontFamily:
                                    GoogleFonts.poppins().fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    fontFamily:
                                    GoogleFonts.poppins().fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String username = usernameController.text;
                          String password = passwordController.text;
                          loginUser(username, password);
                        },
                        // onPressed: () {
                        //   Navigator.pushNamed(context, "/Home");
                        //   // Perform login action
                        // },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF006837),
                          padding: EdgeInsets.zero, // Remove default padding
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10), // Border radius
                          ),
                        ),
                        child: Container(
                          constraints:
                          const BoxConstraints(minHeight: 40), // Set min height
                          alignment: Alignment.center, // Center align the text
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15), // Vertical padding
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      color: Colors.white, // Background color
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'By creating or logging into an account you are agreeing with our Terms and Conditions and Privacy Policy.', // Text inside the container
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> loginUser(String username, String password) async {
    EasyLoading.show(status: 'loading...');
    final response = await http.post(
      Uri.parse('https://flutter-amr.noviindus.in/api/Login'),
      body: {'username': username, 'password': password},
    );
    Map<String, dynamic> value = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        EasyLoading.dismiss();
        var success = value['status'];
        if (success) {
          SharedPrefrence().setToken(value['token'].toString());
          SharedPrefrence().setIsLogged(true);
          Navigator.pushNamed(context, "/Home");
        } else {
          var message = value['message'];
          EasyLoading.showError(message);
        }
      } catch (e) {
        e.toString();
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
      var message = value['message'];
      EasyLoading.showToast(message);
    }
  }
}