import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_sp.dart';
import '../../../utils/app_url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userToken = "";

  List<dynamic> patientData = [];

  void initState() {
    super.initState();
    Future token = SharedPrefrence().getToken();
    token.then((value) {
      setState(() {
        userToken = value;
        patientlist(userToken);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Add functionality to navigate back
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              // Add functionality for bell icon
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Search TextField and Button in the same row
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                45), // Set max height and width for the text field
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for button
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF006837),
                            padding: EdgeInsets.zero, // Remove default padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10), // Border radius
                            ),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 45,
                            ), // Set min height
                            alignment:
                            Alignment.center, // Center align the text
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13), // Vertical padding
                              child: Text(
                                'Search',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          'Sort By :',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 100),
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                40), // Set max height and width for the text field
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: " Date",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // List of cards
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: patientData.length,
                    itemBuilder: (BuildContext context, int index) {
                      var patient = patientData[index];
                      var name = patient['name'];
                      var treatmentDetails = patient['patientdetails_set'][0];
                      var treatmentName = treatmentDetails['treatment_name'];
                      var user = patient['user'];
                      //var date = DateTime.parse(patient['date_nd_time']);

                      var dateString = patient['date_nd_time'];
                      var parsedDate = DateTime.parse(dateString);
                      var day = parsedDate.day.toString().padLeft(2, '0');
                      var month = parsedDate.month.toString().padLeft(2, '0');
                      var year = parsedDate.year.toString();
                      var formattedDate = '$day/$month/$year';

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color: Color(0xFFF1F1F1),
                          child: SizedBox(
                            height: 180,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}.    $name',
                                    style: TextStyle(
                                      fontFamily:
                                      GoogleFonts.poppins().fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  Text(
                                    '$treatmentName',
                                    style: TextStyle(
                                      fontFamily:
                                      GoogleFonts.poppins().fontFamily,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF006837),
                                    ),
                                  ),

                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Color(0xFFF24E1E),
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '$formattedDate',
                                        style: TextStyle(
                                          fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Icon(
                                        Icons.person_rounded,
                                        color: Color(0xFFF24E1E),
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '$user', // Replace this with your actual time from your data source
                                        style: TextStyle(
                                          fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20), // Adjust as needed
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height:
                                          1, // Thickness of your straight line
                                          color: Colors
                                              .black, // Color of your straight line
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20), // Adjust as needed
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'View Booking details',
                                        style: TextStyle(
                                          fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Color(0xFF006837),
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Add the button outside the SingleChildScrollView
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10), // Change the padding as needed
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF006837),
                  padding: EdgeInsets.zero, // Remove default padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  backgroundColor: null, // Remove background color
                ),
                child: Container(
                  constraints: BoxConstraints(minHeight: 40), // Set min height
                  alignment: Alignment.center, // Center align the text
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Vertical padding
                    child: Text(
                      'Register Now',
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
        ],
      ),
    );
  }

  Future<void> patientlist(String userToken) async {
    EasyLoading.show(status: 'Date Fetching...');
    final response = await http.get(Uri.parse(AppUrls.patientlist), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $userToken"
    });
    Map<String, dynamic> value = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        var success = value['status'];
        if (success) {
          setState(() {
            patientData = jsonDecode(response.body)['patient'];
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