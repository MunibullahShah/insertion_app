import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:insertion_app/models/ParcelModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/inputContainer.dart';
import '../apiClasses/OSM_API_CLASS_entity.dart';
import '../apiClasses/parcel_info_api_entity.dart';

class ParcelEditScreen extends StatefulWidget {
  ParcelModel parcel;

  ParcelEditScreen(this.parcel);

  @override
  State<ParcelEditScreen> createState() => _ParcelEditScreenState();
}

class _ParcelEditScreenState extends State<ParcelEditScreen> {
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
  var tempStatus;
  var type;
  var tempType;
  var deliveryType;
  var tempdeliveryType;
  double longitude = 0;
  double latitude = 0;

  bool isLoading = false;
  bool isFound = true;
  var parcelSize;
  var tempSize;

  @override
  void initState() {
    type = widget.parcel.parcelType;
    deliveryType = widget.parcel.deliveryType;
    status = widget.parcel.status;
    parcelSize = "M";

    senderNameController.text = widget.parcel.senderName;
    receiverNameController.text = widget.parcel.receiverName;
    senderAddressController.text = widget.parcel.senderAddress;
    receiverAddressController.text = widget.parcel.address;
    senderPhoneController.text = widget.parcel.senderContact;
    receiverPhoneController.text = widget.parcel.receiverContact;
    weightController.text = widget.parcel.parcelWeight.toString();
    longitudeController.text = widget.parcel.longitude.toString();
    latitudeController.text = widget.parcel.latitude.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Parcel Update"),
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
                          const VerticalDivider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          Column(
                            children: [
                              InputContainer(
                                  label: "Receiver Name",
                                  controller: receiverNameController,
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
                                controller: receiverAddressController,
                                hintText: "Address",
                              ),
                              isFound
                                  ? const SizedBox(
                                      height: 1,
                                    )
                                  : Column(
                                      children: [
                                        InputContainer(
                                          controller: longitudeController,
                                          label: 'Longitude',
                                          hintText: 'longitude',
                                        ),
                                        InputContainer(
                                          controller: latitudeController,
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
                            value: tempType,
                            hint: const Text("type"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                tempType = value as String;
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
                            value: tempSize,
                            hint: const Text("Size"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                tempSize = value as String;
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
                            value: tempdeliveryType,
                            hint: const Text("Select Delivery Type"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                tempdeliveryType = value as String;
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
                            value: tempStatus,
                            hint: const Text("status"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (value) {
                              setState(() {
                                tempStatus = value as String;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                          230,
                          242,
                          255,
                          1,
                        ),
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
                            sendData();
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

  sendData() async {
    // Map<String, dynamic> formData = {
    //   "senderName": senderNameController.text,
    //   "longitude": latitude,
    //   "latitude": longitude,
    //   "address": receiverAddressController.text,
    //   "senderContact": senderPhoneController.text,
    //   "receiverContact": receiverPhoneController.text,
    //   "addedBy": "addedBy",
    //   "receiverName": receiverNameController.text,
    //   "type": tempType == null ? type.toString() : tempType.toString(),
    //   "parcelSize":
    //       tempSize == null ? parcelSize.toString() : tempSize.toString(),
    //   "parcelWeight": weightController.text,
    //   "status": tempStatus == null ? status.toString() : tempStatus.toString(),
    //   "deliveryType": tempdeliveryType == null
    //       ? deliveryType.toString()
    //       : tempdeliveryType.toString(),
    //   "employee": 1,
    // };

    print("${widget.parcel.id}");
    if (tempType != null) {
      type = tempType.toString();
    }
    if (tempStatus != null) {
      status = tempStatus.toString();
    }
    if (tempdeliveryType != null) {
      deliveryType = tempdeliveryType.toString();
    }
    // if (tempSize != null) {
    //   parcelSize = tempSize.toString();
    // }

    //print("Type: $type : $deliveryType ,$status,  $parcelSize");

    try {
      var response = await Dio()
          .put("http://localhost:1337/api/Parcels/${widget.parcel.id}", data: {
        "data": {
          "senderName": senderNameController.text,
          "longitude": latitude,
          "latitude": longitude,
          "address": receiverAddressController.text,
          "senderContact": senderPhoneController.text,
          "receiverContact": receiverPhoneController.text,
          "addedBy": "addedBy",
          "receiverName": receiverNameController.text,
          "type": type,
          "parcelSize": parcelSize,
          "parcelWeight": double.parse(weightController.text),
          "status": status,
          "deliveryType": deliveryType.toString(),
          "employee": 1,
        }
      });
      print(response.data);
      Fluttertoast.showToast(msg: "Parcel Updated");
    } catch (e) {
      print("Exception: $e");
      Fluttertoast.showToast(msg: "Parcel Update Failed");

      setState(() {
        isLoading = false;
      });
    }
  }
}
