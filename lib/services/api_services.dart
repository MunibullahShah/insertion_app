import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:insertion_app/models/ParcelModel.dart';

import '../apiClasses/OSM_API_CLASS_entity.dart';

class ApiServices {
  getLocation(receiverAddress) async {
    OSMAPICLASSEntity _osmapiclassEntity = OSMAPICLASSEntity();
    var latLong = [];
    var response = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=\"+${receiverAddress}+\"&format=geojson'));

    if (response.statusCode == 200) {
//      print('respone: ${response.body}');
      _osmapiclassEntity =
          OSMAPICLASSEntity.fromJson(jsonDecode(response.body));
      if (_osmapiclassEntity.features.isEmpty) {
        // setState(() {
        //   isFound = false;
        // });
        return 1;
        // } else if (!isFound && latitudeController.text != null) {
        //   sendData();
      } else {
        latLong.add(_osmapiclassEntity.features.first.geometry.coordinates[0]);
        latLong.add(_osmapiclassEntity.features.first.geometry.coordinates[1]);
        return latLong;
      }
    } else {
      print(response.statusCode);
      return null;
    }
  }

  sendData(
    var senderName,
    double latitude,
    double longitude,
    var recievierAddress,
    var senderPhone,
    var receiverPhone,
    var receiverName,
    var type,
    var parcelSize,
    var weight,
    var status,
    var deliveryType,
    var employeeNo,
  ) async {
    try {
      if (longitude != null) {
        Map<String, dynamic> formData = {
          "senderName": senderName,
          "longitude": latitude,
          "latitude": longitude,
          "address": recievierAddress,
          "senderContact": senderPhone,
          "receiverContact": receiverPhone,
          "addedBy": "addedBy",
          "receiverName": receiverName,
          "type": type,
          "parcelSize": parcelSize,
          "parcelWeight": weight,
          "status": status,
          "deliveryType": deliveryType,
          "employee": employeeNo,
        };

        String str = json.encode(formData);
        try {
          var response = await Dio().post(
              "https://idms.backend.eastdevs.com/api/parcels",
              data: <String, Map<String, dynamic>>{'data': formData});
          print(response.data);
        } catch (e) {
          print(e.toString());
        }
        return 1;
      }
      // setState(() {
      //   isLoading = !isLoading;
      // });
    } catch (e) {
      print("Exception: $e");

      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  trackParcel(String parcelID) async {
    try{
      // var response = await Dio()
      //     .get("https://idms.backend.eastdevs.com/api/parcels/$parcelID");

      var response=await Dio()
          .get("https://idms.backend.eastdevs.com/api/parcels/$parcelID");
      print(response.data["data"]);
      ParcelModel parcel = ParcelModel(
          id: response.data["data"]['id'].toString(),
          receiverName: response.data["data"]["attributes"]["receiverName"] == null
              ? ""
              : response.data["data"]["attributes"]["receiverName"],
          longitude: response.data["data"]["attributes"]["longitude"] == null
              ? 0
              : response.data["data"]["attributes"]["longitude"],
          latitude: response.data["data"]["attributes"]["latitude"] == null
              ? 0
              : response.data["data"]["attributes"]["longitude"],
          sendingDate: "", //e["attributes"]["sendingDate"]
          address: response.data["data"]["attributes"]["address"] == null
              ? ""
              : response.data["data"]["attributes"]["address"],
          receiverContact: response.data["data"]["attributes"]["receiverContact"] == null
              ? ""
              : response.data["data"]["attributes"]["receiverContact"],
          status: response.data["data"]["attributes"]["status"] == null
              ? ""
              : response.data["data"]["attributes"]["status"],
          parcelWeight: response.data["data"]["attributes"]["parcelWeight"] == null
              ? 0
              : response.data["data"]["attributes"]["parcelWeight"],
          senderName: response.data["data"]["attributes"]["senderName"] == null
              ? ""
              : response.data["data"]["attributes"]["senderName"],
          senderContact: response.data["data"]["attributes"]["senderContact"] == null
              ? ""
              : response.data["data"]["attributes"]["senderContact"],
          parcelType: response.data["data"]["attributes"]["type"] == null
              ? ""
              : response.data["data"]["attributes"]["type"],
          size: response.data["data"]["attributes"]["size"] == null
              ? ""
              : response.data["data"]["attributes"]["size"],
          deliveryType: response.data["data"]["attributes"]["deliveryType"] == null
              ? ""
              : response.data["data"]["attributes"]["deliveryType"],
          destinationNo: response.data["data"]["attributes"]["destinationNo"] == null
              ? 0
              : int.parse(response.data["data"]["attributes"]["destinationNo"]));
      return parcel;
    }on DioError catch(e){
      print("Error Hello");
      Fluttertoast.showToast(msg: "Parcel not Found");
      return 0;
    }
  }
}
