import 'dart:convert';
import 'package:insertion_app/generated/json/base/json_field.dart';
import 'package:insertion_app/generated/json/parcel_info_api_entity.g.dart';

@JsonSerializable()
class ParcelInfoApiEntity {
  late ParcelInfoApiData data;

  ParcelInfoApiEntity();

  factory ParcelInfoApiEntity.fromJson(Map<String, dynamic> json) =>
      $ParcelInfoApiEntityFromJson(json);

  Map<String, dynamic> toJson() => $ParcelInfoApiEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ParcelInfoApiData {
  late String senderName;
  late double longitude;
  late double latitude;
  late String address;
  late String senderContact;
  late String receiverContact;
  late String addedBy;
  late String receiverName;
  late String type;
  late String parcelSize;
  late String parcelWeight;
  late String status;
  late String deliveryType;

  ParcelInfoApiData();

  factory ParcelInfoApiData.fromJson(Map<String, dynamic> json) =>
      $ParcelInfoApiDataFromJson(json);

  Map<String, dynamic> toJson() => $ParcelInfoApiDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
