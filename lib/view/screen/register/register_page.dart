import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_sp.dart';
import '../../../utils/app_url.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _paymentOption;
  String userToken = "";
  List<dynamic> brancheData = [];


  void initState() {
    super.initState();
    _paymentOption = 'cash';
    Future token = SharedPrefrence().getToken();
    token.then((value) {
      setState(() {
        userToken = value;
        branchlist(userToken);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
              // Add functionality to navigate back
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black,),
              onPressed: () {
                // Add functionality for bell icon
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: GoogleFonts
                      .poppins()
                      .fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 1, // Thickness of your straight line
                      color: Colors.black, // Color of your straight line
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [


                      Text('Name',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            hintText: 'Enter your Name',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),

                      Text('Whatsapp Number',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            hintText: 'Enter your Whatsapp number',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),


                      Text('Address',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            hintText: 'Enter your full address',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),


                      Text(
                        'Location',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            hintText: 'Choose your location',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                          items: <String>[
                            'Kozhikkod',
                            'Malapuram',
                            'Palakkad',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {

                          },
                        ),
                      ),
                      SizedBox(height: 23),


                      Text(
                        'Branch',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            hintText: 'Select the branch',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                          items: brancheData.map<DropdownMenuItem<String>>((
                              branch) {
                            return DropdownMenuItem<String>(
                              value: branch['name'],
                              child: Text(branch['name']),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // Handle dropdown value change
                          },
                        ),

                      ),
                      SizedBox(height: 23),


                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 300,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Center(
                                    child: Text("Your Modal Content Here"),
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFC3E0C8),
                            padding: EdgeInsets.zero, // Remove default padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Border radius
                            ),
                            backgroundColor: null, // Remove background color
                          ),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 40),
                            // Set min height
                            alignment: Alignment.center,
                            // Center align the text
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              // Vertical padding
                              child: Text(
                                '+ Add Treatments',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: GoogleFonts
                                      .poppins()
                                      .fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 23),


                      //////


                      Text('Total Amount',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            hintText: 'Total Amount',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),


                      Text('Discount Amount',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            hintText: 'Discount Amount',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),


                      Text(
                        'Payment Option',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('Cash',
                                style: TextStyle(
                                  fontFamily: GoogleFonts
                                      .poppins()
                                      .fontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),),
                              value: 'cash',
                              groupValue: _paymentOption,
                              onChanged: (String? value) {
                                setState(() {
                                  _paymentOption = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('Card',
                                style: TextStyle(
                                  fontFamily: GoogleFonts
                                      .poppins()
                                      .fontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),),
                              value: 'card',
                              groupValue: _paymentOption,
                              onChanged: (String? value) {
                                setState(() {
                                  _paymentOption = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('UPI',
                                style: TextStyle(
                                  fontFamily: GoogleFonts
                                      .poppins()
                                      .fontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),),
                              value: 'upi',
                              groupValue: _paymentOption,
                              onChanged: (String? value) {
                                setState(() {
                                  _paymentOption = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 23),


                      Text('Advance Amount',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),

                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),

                      Text('Balance Amount',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),

                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),

                      Text('Treatment Date',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                            suffixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),


                      Text('Treatment Time',
                        style: TextStyle(
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width, // Set container width to screen width
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                // You can set any width you desire here
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                // Example width, adjust as needed
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    hintText: 'Hour',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 16.0),
                                    suffixIcon: Icon(
                                        Icons.calendar_today_outlined),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                // You can set any width you desire here
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                // Example width, adjust as needed
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    hintText: 'Minutes',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 16.0),
                                    suffixIcon: Icon(
                                        Icons.calendar_today_outlined),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: 23),


                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Perform login action
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF006837),
                            padding: EdgeInsets.zero, // Remove default padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Border radius
                            ),
                            backgroundColor: null, // Remove background color
                          ),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 40),
                            // Set min height
                            alignment: Alignment.center,
                            // Center align the text
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              // Vertical padding
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontFamily: GoogleFonts
                                      .poppins()
                                      .fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
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

  Future<void> branchlist(String userToken) async {
    final response = await http.get(Uri.parse(AppUrls.branchlist), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $userToken"
    });

    Map<String, dynamic> value = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        var success = value['status'];
        if (success) {
          setState(() {
            brancheData = jsonDecode(response.body)['branches'];
          });
          EasyLoading.dismiss();
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

