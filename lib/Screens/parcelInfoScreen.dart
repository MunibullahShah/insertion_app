import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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

  OSMAPICLASSEntity _osmapiclassEntity = OSMAPICLASSEntity();

  ParcelInfoApiEntity apiEntity = ParcelInfoApiEntity();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var status;
  var type;
  var deliveryType;
  var longitude;
  var latitude;

  bool isLoading = false;
  bool isFound = true;
  var parcelSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parcel Data Insertion"),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 300,
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
                                label: "Receiver Phone No.",
                                controller: senderPhoneController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputContainer(
                                label: "Receiver Address",
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
                              'letter',
                              'parcel',
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
                          width: 200,
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
                    GestureDetector(
                      child: Container(
                        child: Text("Submit"),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          sendData();
                        }
                      },
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
      print('respone: ${response.body}');
      _osmapiclassEntity =
          OSMAPICLASSEntity.fromJson(jsonDecode(response.body));
      if (_osmapiclassEntity.features.isEmpty) {
        Fluttertoast.showToast(msg: 'Error getting location');
        isFound = false;
      } else {
        longitude = _osmapiclassEntity.features.first.geometry.coordinates[0];
        latitude = _osmapiclassEntity.features.first.geometry.coordinates[1];
      }
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(msg: 'Error getting location');
    }
  }

  sendData() async {
    setState(() {
      isLoading = !isLoading;
    });
    getLocation();
    if (longitude != null) {
      var response = await http.post(
          Uri.parse('https://idms.backend.eastdevs.com/api/parcels/'),
          body: jsonEncode(<String, dynamic>{
            "data": {
              "senderName": senderNameController.text,
              "longitude": longitude,
              "latitude": latitude,
              "address": receiverAddressController.text,
              "senderContact": senderPhoneController.text,
              "receiverContact": receiverPhoneController.text,
              "addedBy": '',
              "receiverName": receiverNameController.text,
              "type": type,
              "parcelSize": parcelSize,
              "parcelWeight": weightController.text,
              "status": status,
              "deliveryType": deliveryType,
            }
          }));
      print(response.statusCode);
      print(response.body);
    }
    setState(() {
      isLoading = !isLoading;
    });
  }
}
