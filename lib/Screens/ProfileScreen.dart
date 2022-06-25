import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insertion_app/Screens/profileEditScreen.dart';
import 'package:insertion_app/Screens/HomeRequestScreen.dart';
import 'package:insertion_app/Widgets/appButton.dart';
import 'package:insertion_app/models/employee.dart';

class ProfileScreen extends StatefulWidget {
  String employeeID = "6";

  // ProfileScreen({this.employeeID});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  @override
  void initState() {
    user.id = widget.employeeID;
    setState(() {
      isLoading = true;
    });
    getEmployeeData();
    super.initState();
  }

  Employee user = Employee();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              // child: RaisedButton(
              //   color: Color.fromRGBO(0, 153, 51, 1),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => EditScreen(user),
              //       ),
              //     );
              //     print("Hello");
              //   },
              //   child: Text("Edit Profile"),
              // ),
              child: appButton(
                "Edit Profile",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(user),
                    ),
                  );
                  print("Hello");
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: appButton(
                "Logout",
                () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const HomeScreenRequestScreen()),
                      (route) => false);

                  print("Hello");
                },
              ),
            ),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5.0, 5.0),
                      )
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * (0.70),
                  width: MediaQuery.of(context).size.width * (0.75),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(255, 214, 77, 1),
                        ),
                        // height: MediaQuery.of(context).size.height * (0.70),
                        width: (MediaQuery.of(context).size.width * (0.75)) *
                            (0.30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              height:
                                  (MediaQuery.of(context).size.width * (0.75)) *
                                      (0.30) *
                                      (0.80),
                              width:
                                  (MediaQuery.of(context).size.width * (0.75)) *
                                      (0.30) *
                                      (0.80),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image(
                                  image: NetworkImage(
                                      "https://th.bing.com/th/id/R.cd6d11ef068a3f0d483a61b73044e4ea?rik=6L9rWMoFYxvwNg&pid=ImgRaw&r=0"),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                user.name!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Colors.white,
                        ),
                        height: MediaQuery.of(context).size.height * (0.70),
                        width: (MediaQuery.of(context).size.width * (0.75)) *
                            (0.70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Address:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    user.address!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Phone:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    user.phone!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "NIC",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    user.nic!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  getEmployeeData() async {
    try {
      var response = await Dio().get(
          "https://idms.backend.eastdevs.com/api/employees/${widget.employeeID}");
      print(response.data['data']['attributes']);
      user.name = response.data['data']['attributes']["name"];
      user.email = response.data['data']['attributes']["email"];
      user.address = response.data['data']['attributes']["address"];
      user.nic = response.data['data']['attributes']["nic_no"];
      user.phone = response.data['data']['attributes']["phone_num"];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}
