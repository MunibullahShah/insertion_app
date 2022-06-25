import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:insertion_app/Screens/HomeRequestScreen.dart';
import 'package:insertion_app/Screens/ProfileScreen.dart';
import 'package:insertion_app/Screens/parcelsListScreen.dart';
import 'package:insertion_app/Widgets/appButton.dart';
import 'package:insertion_app/apiClasses/OSM_API_CLASS_entity.dart';
import 'package:insertion_app/apiClasses/parcel_info_api_entity.dart';
import 'package:insertion_app/constants.dart';

import '../Widgets/inputContainer.dart';

class ParcelInfoScreen extends StatefulWidget {
  String employeeID;

  ParcelInfoScreen(this.employeeID);

  @override
  State<ParcelInfoScreen> createState() => _ParcelInfoScreenState();
}

class _ParcelInfoScreenState extends State<ParcelInfoScreen> {
  TextEditingController senderNameController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController senderAddressController = TextEditingController();
  TextEditingController receiverAddressController = TextEditingController();
  TextEditingController senderPhoneController = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  OSMAPICLASSEntity _osmapiclassEntity = OSMAPICLASSEntity();
  ParcelInfoApiEntity apiEntity = ParcelInfoApiEntity();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var status = "Scheduling";
  var type;
  var deliveryType = "Delivery";
  double longitude = 0;
  double latitude = 0;

  bool isLoading = false;
  bool isFound = true;
  var parcelSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Parcel Data Insertion"),
          actions: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: appButton(
                "Profile",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: appButton(
                "Parcels",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ParcelsListScreen(widget.employeeID),
                    ),
                  );
                  print("Parcels");
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 214, 77, 1),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5.0, 5.0),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Container(
                            child: Text(
                              "Welcome Again\nYou have been Missed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Satisfy',
                                  fontSize: 40),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // color: Color.fromRGBO(255, 214, 77, 1),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(5.0, 5.0),
                                )
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 320,
                                    padding: const EdgeInsets.all(30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            InputContainer(
                                              label: "Sender Name",
                                              controller: senderNameController,
                                              hintText: "John Doe",
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InputContainer(
                                              label: "Sender Phone No.",
                                              controller: senderPhoneController,
                                              hintText: "12345",
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InputContainer(
                                              label: "Sender Address",
                                              controller:
                                                  senderAddressController,
                                              hintText: "Address",
                                            ),
                                          ],
                                        ),
                                        const VerticalDivider(
                                          thickness: 1,
                                          color: Colors.black,
                                        ),
                                        Column(
                                          children: [
                                            InputContainer(
                                                label: "Receiver Name",
                                                controller:
                                                    receiverNameController,
                                                hintText: "John Dree"),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InputContainer(
                                              label: "Receiver Phone No.",
                                              controller:
                                                  receiverPhoneController,
                                              hintText: "1235543",
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InputContainer(
                                              label: "Receiver Address",
                                              controller:
                                                  receiverAddressController,
                                              hintText: "Address",
                                            ),
                                            isFound
                                                ? const SizedBox(
                                                    height: 1,
                                                  )
                                                : Column(
                                                    children: [
                                                      InputContainer(
                                                        controller:
                                                            longitudeController,
                                                        label: 'Longitude',
                                                        hintText: 'longitude',
                                                      ),
                                                      InputContainer(
                                                        controller:
                                                            latitudeController,
                                                        label: "latitude",
                                                        hintText: "latitude",
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: 120,
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 0, 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                              230,
                                              242,
                                              255,
                                              1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          height: 30,
                                          child: DropdownButton(
                                            alignment: Alignment.center,
                                            underline:
                                                DropdownButtonHideUnderline(
                                                    child: Container()),
                                            items: <String>[
                                              'Letter',
                                              'Parcel',
                                            ].map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            value: type,
                                            hint: const Text("Type"),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            onChanged: (value) {
                                              setState(() {
                                                type = value as String;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 0, 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                              230,
                                              242,
                                              255,
                                              1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          height: 30,
                                          child: DropdownButton(
                                            alignment: Alignment.center,
                                            underline:
                                                DropdownButtonHideUnderline(
                                              child: Container(),
                                            ),
                                            items: <String>[
                                              'XS',
                                              'S',
                                              'M',
                                              'L',
                                              'XL',
                                              'XXL',
                                            ].map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            value: parcelSize,
                                            hint: const Text("Size"),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            onChanged: (value) {
                                              setState(() {
                                                parcelSize = value as String;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     color: Color.fromRGBO(
                                  //       230,
                                  //       242,
                                  //       255,
                                  //       1,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(8),
                                  //   ),
                                  //   alignment: Alignment.center,
                                  //   height: 30,
                                  //   width: 70,
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       if (_formKey.currentState!.validate()) {
                                  //         setState(() {
                                  //           isLoading = !isLoading;
                                  //         });
                                  //         getLocation();
                                  //       }
                                  //     },
                                  //     child: Text("Submit"),
                                  //   ),
                                  // ),
                                  appButton(
                                    "Submit",
                                    () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = !isLoading;
                                        });
                                        getLocation();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  getLocation() async {
    var response = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=\"+${receiverAddressController.text}+\"&format=geojson'));

    if (response.statusCode == 200) {
//      print('respone: ${response.body}');
      _osmapiclassEntity =
          OSMAPICLASSEntity.fromJson(jsonDecode(response.body));
      if (_osmapiclassEntity.features.isEmpty && isFound) {
        setState(() {
          isFound = false;
        });
        return;
      } else if (!isFound && latitudeController.text != null) {
        sendData();
      } else {
        longitude = (_osmapiclassEntity.features.first.geometry.coordinates[0]);
        latitude = _osmapiclassEntity.features.first.geometry.coordinates[1];
        sendData();
      }
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(msg: 'Error getting location');
      setState(() {
        isFound = false;
      });
    }
  }

  sendData() async {
    try {
      //getLocation();
      if (!isFound) {
        apiEntity.data.longitude = double.parse(longitudeController.text);
        apiEntity.data.latitude = double.parse(latitudeController.text);
      }
      if (longitude != null) {
        Map<String, dynamic> formData = {
          "senderName": senderNameController.text,
          "longitude": latitude,
          "latitude": longitude,
          "address": receiverAddressController.text,
          "senderContact": senderPhoneController.text,
          "receiverContact": receiverPhoneController.text,
          "addedBy": "addedBy",
          "receiverName": receiverNameController.text,
          "type": type.toString(),
          "parcelSize": parcelSize.toString(),
          "parcelWeight": weightController.text,
          "status": status.toString(),
          "deliveryType": deliveryType.toString(),
          "employee": widget.employeeID,
        };
        try {
          var response = await Dio().post(
              "https://idms.backend.eastdevs.com/api/parcels",
              data: <String, Map<String, dynamic>>{'data': formData});
          print(response.data);
          setState(() {
            isLoading = !isLoading;
          });
        } catch (e) {
          Fluttertoast.showToast(msg: "Failed");
          setState(() {
            isLoading = !isLoading;
          });
          print(e.toString());
        }
        Fluttertoast.showToast(msg: "Successfull");
        return 1;
      }
      setState(() {
        isLoading = !isLoading;
      });
    } catch (e) {
      print("Exception: $e");
      Fluttertoast.showToast(msg: "Failed");

      setState(() {
        isLoading = false;
      });
    }
  }
}
