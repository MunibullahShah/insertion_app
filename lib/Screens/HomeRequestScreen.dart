import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:insertion_app/Screens/login.dart';
import '../Widgets/inputContainer.dart';
import '../apiClasses/OSM_API_CLASS_entity.dart';
import '../apiClasses/parcel_info_api_entity.dart';

class HomeScreenRequestScreen extends StatefulWidget {
  const HomeScreenRequestScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreenRequestScreen> createState() =>
      _HomeScreenRequestScreenState();
}

class _HomeScreenRequestScreenState extends State<HomeScreenRequestScreen> {
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
  var deliveryType = "Pickup";
  double longitude = 0;
  double latitude = 0;

  bool isLoading = false;
  bool isFound = true;
  var parcelSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(
        230,
        242,
        255,
        1,
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 10),
            child: RaisedButton(
              color: Color.fromRGBO(0, 153, 51, 1),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("Login"),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 214, 77, 1),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5.0, 5.0),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            child: Image(
                              image: AssetImage("aaaa.png"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                            child: Form(
                          key: _formKey,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                              15,
                              30,
                              15,
                              0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Parcel Info for Pickup",
                                    style: TextStyle(fontSize: 27),
                                  ),
                                ),
                                Container(
                                  height: 300,
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 30, 10, 0),
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
                                            controller: senderAddressController,
                                            hintText: "Address",
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
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
                                            controller: receiverPhoneController,
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
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 120,
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 10),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(
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
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 10),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(
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
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 10),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                            230,
                                            242,
                                            255,
                                            1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Parcel weight: "),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 50,
                                              child: TextField(
                                                controller: weightController,
                                                textAlign: TextAlign.center,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 153, 51, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text("Submit"),
                                  ),
                                  onTap: () {
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
                        )),
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
          "employee": 1
        };

        String str = json.encode(formData);
        try {
          var response = await Dio().post(
              "https://idms.backend.eastdevs.com/api/parcels",
              data: <String, Map<String, dynamic>>{'data': formData});
          print(response.data);
          setState(() {
            isLoading = !isLoading;
          });
        } catch (e) {
          setState(() {
            isLoading = !isLoading;
          });
          print(e.toString());
        }
        return 1;
      }
      setState(() {
        isLoading = !isLoading;
      });
    } catch (e) {
      print("Exception: $e");

      setState(() {
        isLoading = false;
      });
    }
  }
}
