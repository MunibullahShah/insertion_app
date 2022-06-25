import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:insertion_app/Screens/login.dart';
import 'package:insertion_app/Widgets/appButton.dart';
import 'package:insertion_app/Widgets/informationContainer.dart';
import 'package:insertion_app/services/api_services.dart';
import '../Widgets/inputContainer.dart';
import '../apiClasses/OSM_API_CLASS_entity.dart';
import '../apiClasses/parcel_info_api_entity.dart';
import '../constants.dart';

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

  TextEditingController trackingNoController = TextEditingController();

  OSMAPICLASSEntity _osmapiclassEntity = OSMAPICLASSEntity();

  ParcelInfoApiEntity apiEntity = ParcelInfoApiEntity();

  ApiServices _apiServices = ApiServices();

  GlobalKey<FormState> _parcelFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _trackingKey = GlobalKey<FormState>();
  var status = "Scheduling";
  var type;
  var deliveryType = "Pickup";
  var parcel;
  double longitude = 0;
  double latitude = 0;

  bool isLoading = false;
  bool isParcelTracked = false;
  bool isParcelTracking = false;
  bool isFound = true;
  var parcelSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(
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
            padding: const EdgeInsets.only(right: 10),
            child: appButton(
              isParcelTracked ? "Home" : "Login",
              () {
                if (isParcelTracked) {
                  setState(() {
                    trackingNoController.text = '';
                    isParcelTracking = false;
                    isParcelTracked = false;
                    isLoading = false;
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              },
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
                            child: const Image(
                              image: AssetImage("aaaa.png"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                              15,
                              30,
                              15,
                              0,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: isParcelTracking
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : isParcelTracked
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            child: const Text(
                                              "Parcel Information",
                                              style: TextStyle(fontSize: 27),
                                            ),
                                          ),
                                          Container(
                                            height: 250,
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 30, 10, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                //Column for Sender
                                                Column(
                                                  children: [
                                                    InformationContainer(
                                                        label: "Sender Name",
                                                        text:
                                                            parcel.senderName),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    InformationContainer(
                                                        label: "Address",
                                                        text: parcel.address),
                                                  ],
                                                ),
                                                //Column of reciever
                                                Column(
                                                  children: [
                                                    InformationContainer(
                                                        label: "Receiver Name",
                                                        text: parcel
                                                            .receiverName),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    InformationContainer(
                                                        label: "Status",
                                                        text: parcel.status),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: const Text(
                                              "Parcel Info for Pickup",
                                              style: TextStyle(fontSize: 27),
                                            ),
                                          ),
                                          Container(
                                            height: 250,
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 30, 10, 0),
                                            child: Form(
                                              key: _parcelFormKey,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      InputContainer(
                                                        label: "Sender Name",
                                                        controller:
                                                            senderNameController,
                                                        hintText: "John Doe",
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      InputContainer(
                                                        label:
                                                            "Sender Phone No.",
                                                        controller:
                                                            senderPhoneController,
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
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    children: [
                                                      InputContainer(
                                                          label:
                                                              "Receiver Name",
                                                          controller:
                                                              receiverNameController,
                                                          hintText:
                                                              "John Dree"),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      InputContainer(
                                                        label:
                                                            "Receiver Phone No.",
                                                        controller:
                                                            receiverPhoneController,
                                                        hintText: "1235543",
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      InputContainer(
                                                        label:
                                                            "Receiver Address",
                                                        controller:
                                                            receiverAddressController,
                                                        hintText: "Address",
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          ///Validation till here
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: 120,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 0, 10),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                      230,
                                                      242,
                                                      255,
                                                      1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 0, 10),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                      230,
                                                      242,
                                                      255,
                                                      1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        parcelSize =
                                                            value as String;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          appButton("Submit", () {
                                            if (_parcelFormKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                              getLocation();
                                            }
                                          }),
                                          Container(
                                            height: 50,
                                            child: const Divider(
                                              height: 20,
                                              thickness: 2,
                                              indent: 20,
                                              endIndent: 0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Form(
                                            key: _trackingKey,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InputContainer(
                                                  label: "Tracking No",
                                                  controller:
                                                      trackingNoController,
                                                  hintText: "123",
                                                  obscure: false,
                                                ),
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                appButton("Track", () async {
                                                  if (_trackingKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      isParcelTracking = true;
                                                    });
                                                    trackParcel();
                                                  }
                                                }),
                                              ],
                                            ),
                                          ),
                                        ],
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
        isLoading = false;
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
          Fluttertoast.showToast(
              msg: "Successfull, Tracking No: ${response.data['data']['id']}");
          setState(() {
            isLoading = !isLoading;
          });
        } catch (e) {
          setState(() {
            isLoading = !isLoading;
          });
          print(e.toString());
          Fluttertoast.showToast(msg: "Failed");
          return 1;
        }
        {
          senderNameController.clear();
          receiverNameController.clear();
          senderAddressController.clear();
          receiverAddressController.clear();
          senderPhoneController.clear();
          receiverPhoneController.clear();
          receiverPhoneController.clear();
          longitudeController.clear();
          latitudeController.clear();
          trackingNoController.clear();
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

  void trackParcel() async {
    try {
      parcel = await _apiServices.trackParcel(trackingNoController.text);
    } catch (e) {
      setState(() {
        isParcelTracking = false;
      });
    }
    if (parcel.id != null) {
      setState(() {
        isLoading = false;
        isParcelTracking = false;
        isParcelTracked = true;
      });
    }
    print("Here it comes");
  }
}
