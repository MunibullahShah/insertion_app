import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:insertion_app/Screens/login.dart';
import 'package:insertion_app/Widgets/appButton.dart';
import 'package:insertion_app/Widgets/informationContainer.dart';
import 'package:insertion_app/services/api_services.dart';
import 'package:intl/intl.dart';
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
                                                      isFound
                                                          ? InputContainer(
                                                              label:
                                                                  "Receiver Address",
                                                              controller:
                                                                  receiverAddressController,
                                                              hintText:
                                                                  "Address",
                                                            )
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  //height: 43,
                                                                  width: 120,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          "Lat: "),
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color.fromRGBO(
                                                                            230,
                                                                            242,
                                                                            255,
                                                                            1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            40,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            TextFormField(
                                                                          minLines:
                                                                              1,
                                                                          controller:
                                                                              latitudeController,
                                                                          validator:
                                                                              (value) {
                                                                            if (value == null ||
                                                                                value.isEmpty) {
                                                                              return 'Required';
                                                                            }
                                                                          },
                                                                          textAlignVertical:
                                                                              TextAlignVertical.center,
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                "0.000",
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              borderSide: BorderSide.none,
                                                                            ),
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  //height: 43,
                                                                  width: 120,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          "Long: "),
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color.fromRGBO(
                                                                            230,
                                                                            242,
                                                                            255,
                                                                            1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            50,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            TextFormField(
                                                                          minLines:
                                                                              1,
                                                                          controller:
                                                                              longitudeController,
                                                                          validator:
                                                                              (value) {
                                                                            if (value == null ||
                                                                                value.isEmpty) {
                                                                              return 'Required';
                                                                            }
                                                                          },
                                                                          textAlignVertical:
                                                                              TextAlignVertical.center,
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                "0.000",
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              borderSide: BorderSide.none,
                                                                            ),
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
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
        Fluttertoast.showToast(msg: "Failed! Enter Latitude, Longitude");
        setState(() {
          isLoading = false;
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
      DateTime now = DateTime.now();
      // DateTime date = new DateTime(now.year, now.month, now.day);
      // String today = "${now.year}-${now.month}-${now.day}";

      String formatter = DateFormat('yyyy-MM-dd').format(DateTime.now());
      print("DAAAATTTTEEEEE: $formatter");
      if (!isFound) {
        longitude = double.parse(longitudeController.text);
        latitude = double.parse(latitudeController.text);
      }
      if (longitude != null) {
        Map<String, dynamic> formData = {
          "senderName": senderNameController.text,
          "longitude": longitude,
          "latitude": latitude,
          "address": receiverAddressController.text,
          "senderContact": senderPhoneController.text,
          "receiverContact": receiverPhoneController.text,
          "addedBy": "addedBy",
          "receiverName": receiverNameController.text,
          "type": type.toString(),
          "parcelSize": parcelSize.toString(),
          "parcelWeight": 0,
          "status": status.toString(),
          "sendingDate": formatter,
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
        } on DioError catch (e) {
          setState(() {
            isLoading = !isLoading;
          });
          print("rerererere   ${e.response?.data}");
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
          isFound = true;
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
