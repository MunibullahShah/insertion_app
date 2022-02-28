import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widgets/inputContainer.dart';

class ParcelInfoScreen extends StatefulWidget {
  ParcelInfoScreen({Key? key}) : super(key: key);

  @override
  State<ParcelInfoScreen> createState() => _ParcelInfoScreenState();
}

class _ParcelInfoScreenState extends State<ParcelInfoScreen> {
  FocusNode _focus = FocusNode();

  TextEditingController senderNameController = TextEditingController();

  TextEditingController recieverNameController = TextEditingController();

  TextEditingController senderAddressController = TextEditingController();

  TextEditingController recieverAddressController = TextEditingController();

  TextEditingController senderPhoneController = TextEditingController();

  TextEditingController receiverPhoneController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focus.addListener(_addressFocusChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focus.removeListener(_addressFocusChange);
  }

  var parcelType;
  var parcelSize;
  var deliveryType;
  var status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parcel Data Insertion"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Sender Name:"),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 150,
                              child: TextField(
                                controller: senderNameController,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 30,
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Sender Address:"),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 150,
                              child: TextField(
                                controller: senderAddressController,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 30,
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Sender phone No:"),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 150,
                              child: TextField(
                                controller: senderPhoneController,
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
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Column(
                    children: [
                      InputContainer(
                        label: "Receiver Name",
                        controller: recieverNameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputContainer(
                        label: "Receiver Address",
                        controller: recieverAddressController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputContainer(
                        label: "Receiver Phone No.",
                        controller: receiverPhoneController,
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
                    value: parcelType,
                    hint: const Text("type"),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (value) {
                      setState(() {
                        parcelType = value;
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
                        parcelSize = value;
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
                        deliveryType = value;
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
                        status = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addressFocusChange() {
    setState(() {
      if (!_focus.hasFocus) {
        isLoading = true;
      }
    });
    getLocation();
    setState(() {
      isLoading = false;
    });
  }

  getLocation() async {
    var response = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=\"+${recieverAddressController.text}+\"&format=geojson'));

    if (response.statusCode == 200) {
      print('respone: ${response.body}');
      return await jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
