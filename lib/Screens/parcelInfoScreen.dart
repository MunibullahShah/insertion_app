import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:insertion_app/Screens/HomeRequestScreen.dart';
import 'package:insertion_app/Screens/ProfileScreen.dart';
import 'package:insertion_app/apiClasses/OSM_API_CLASS_entity.dart';
import 'package:insertion_app/apiClasses/parcel_info_api_entity.dart';

import '../Widgets/inputContainer.dart';

class ParcelInfoScreen extends StatefulWidget {
  ParcelInfoScreen({Key? key}) : super(key: key);

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

  var status;
  var type;
  var deliveryType;
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
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                  print("Hello");
                },
                child: Text("Profile"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreenRequestScreen()),
                  );
                  print("Hello");
                },
                child: Text("Logout"),
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 320,
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              InputContainer(
                                label: "Sender Name",
                                controller: senderNameController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputContainer(
                                label: "Sender Phone No.",
                                controller: senderPhoneController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputContainer(
                                label: "Sender Address",
                                controller: senderAddressController,
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
                                controller: receiverNameController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputContainer(
                                label: "Receiver Phone No.",
                                controller: receiverPhoneController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputContainer(
                                label: "Receiver Address",
                                controller: receiverAddressController,
                              ),
                              isFound
                                  ? const SizedBox(
                                      height: 1,
                                    )
                                  : Column(
                                      children: [
                                        InputContainer(
                                            controller: longitudeController,
                                            label: 'Longitude'),
                                        InputContainer(
                                            controller: latitudeController,
                                            label: "latitude"),
                                      ],
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 30,
                          child: DropdownButton(
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
                            hint: const Text("type"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                type = value as String;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 30,
                          child: DropdownButton(
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
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                parcelSize = value as String;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Parcel weight: "),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 50,
                                child: TextField(
                                  controller: weightController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 30,
                          child: DropdownButton(
                            items: <String>[
                              'Delivery',
                              'Pickup',
                            ].map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            value: deliveryType,
                            hint: const Text("Select Delivery Type"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                deliveryType = value as String;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                        Container(
                          height: 30,
                          child: DropdownButton(
                            items: <String>[
                              'Received',
                              'Scheduling',
                              'Scheduled',
                              'Delivering',
                              'Delivered',
                            ].map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            value: status,
                            hint: const Text("status"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                status = value as String;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      height: 30,
                      width: 70,
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            getLocation();
                          }
                        },
                        child: Text("Submit"),
                      ),
                    ),
                  ],
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
          "employee": 1
        };

        String str = json.encode(formData);
        try {
          var response = await Dio().post(
              "https://idms.backend.eastdevs.com/api/parcels",
              data: <String, Map<String, dynamic>>{'data': formData});
          print(response.data);
          setState(() {
            weightController.clear();
            receiverNameController.clear();
            senderNameController.clear();
            receiverPhoneController.clear();
            senderPhoneController.clear();
            receiverAddressController.clear();
            senderAddressController.clear();
            isLoading = !isLoading;
            _formKey.currentState!.reset();
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
