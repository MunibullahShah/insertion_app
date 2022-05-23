import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insertion_app/Screens/ParcelEditScreen.dart';
import 'package:insertion_app/models/ParcelModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParcelsListScreen extends StatefulWidget {
  String employeeID;

  ParcelsListScreen(this.employeeID);

  @override
  State<ParcelsListScreen> createState() => _ParcelsListScreenState();
}

class _ParcelsListScreenState extends State<ParcelsListScreen> {
  bool isLoading = true;
  List<ParcelModel> parcels = [];

  @override
  void initState() {
    getParcels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parcels"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                itemCount: parcels.length,
                itemBuilder: (BuildContext context, int index) {
                  return tile(parcels[index]);
                },
              ),
            ),
    );
  }

  Widget tile(ParcelModel parcel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 5),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width * 0.60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    parcel.id,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    parcel.deliveryType,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: parcel.deliveryType == "Delivery"
                          ? Colors.green
                          : Colors.red,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parcel.receiverName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    parcel.address,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => ParcelEditScreen(parcel)));
                },
                child: Column(
                  children: [
                    const Text(
                      "Edit >",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * 0.12,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getParcels() async {
    try {
      await Dio()
          .get(
              "http://localhost:1337/api/Parcels?filters[employee][id][\$eq]=${widget.employeeID}")
          .then((value) {
        print(value.data);
        value.data["data"].forEach((e) {
          var parcel = ParcelModel(
              id: e['id'].toString(),
              receiverName: e["attributes"]["receiverName"] == null
                  ? ""
                  : e["attributes"]["receiverName"],
              longitude: e["attributes"]["longitude"] == null
                  ? 0
                  : e["attributes"]["longitude"],
              latitude: e["attributes"]["latitude"] == null
                  ? 0
                  : e["attributes"]["longitude"],
              sendingDate: "", //e["attributes"]["sendingDate"]
              address: e["attributes"]["address"] == null
                  ? ""
                  : e["attributes"]["address"],
              receiverContact: e["attributes"]["receiverContact"] == null
                  ? ""
                  : e["attributes"]["receiverContact"],
              status: e["attributes"]["status"] == null
                  ? ""
                  : e["attributes"]["status"],
              parcelWeight: e["attributes"]["parcelWeight"] == null
                  ? 0
                  : e["attributes"]["parcelWeight"],
              senderName: e["attributes"]["senderName"] == null
                  ? ""
                  : e["attributes"]["senderName"],
              senderContact: e["attributes"]["senderContact"] == null
                  ? ""
                  : e["attributes"]["senderContact"],
              parcelType: e["attributes"]["type"] == null
                  ? ""
                  : e["attributes"]["type"],
              size: e["attributes"]["size"] == null
                  ? ""
                  : e["attributes"]["size"],
              deliveryType: e["attributes"]["deliveryType"] == null
                  ? ""
                  : e["attributes"]["deliveryType"],
              destinationNo: e["attributes"]["destinationNo"] == null
                  ? 1
                  : e["attributes"]["destinationNo"]);
          parcels.add(parcel);
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }
}
