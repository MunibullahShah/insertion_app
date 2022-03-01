import 'package:insertion_app/generated/json/base/json_convert_content.dart';
import 'package:insertion_app/apiClasses/parcel_info_api_entity.dart';

ParcelInfoApiEntity $ParcelInfoApiEntityFromJson(Map<String, dynamic> json) {
  final ParcelInfoApiEntity parcelInfoApiEntity = ParcelInfoApiEntity();
  final ParcelInfoApiData? data =
      jsonConvert.convert<ParcelInfoApiData>(json['data']);
  if (data != null) {
    parcelInfoApiEntity.data = data;
  }
  return parcelInfoApiEntity;
}

Map<String, dynamic> $ParcelInfoApiEntityToJson(ParcelInfoApiEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data.toJson();
  return data;
}

ParcelInfoApiData $ParcelInfoApiDataFromJson(Map<String, dynamic> json) {
  final ParcelInfoApiData parcelInfoApiData = ParcelInfoApiData();
  final String? senderName = jsonConvert.convert<String>(json['senderName']);
  if (senderName != null) {
    parcelInfoApiData.senderName = senderName;
  }
  final double? longitude = jsonConvert.convert<double>(json['longitude']);
  if (longitude != null) {
    parcelInfoApiData.longitude = longitude;
  }
  final double? latitude = jsonConvert.convert<double>(json['latitude']);
  if (latitude != null) {
    parcelInfoApiData.latitude = latitude;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    parcelInfoApiData.address = address;
  }
  final String? senderContact =
      jsonConvert.convert<String>(json['senderContact']);
  if (senderContact != null) {
    parcelInfoApiData.senderContact = senderContact;
  }
  final String? receiverContact =
      jsonConvert.convert<String>(json['receiverContact']);
  if (receiverContact != null) {
    parcelInfoApiData.receiverContact = receiverContact;
  }
  final String? addedBy = jsonConvert.convert<String>(json['addedBy']);
  if (addedBy != null) {
    parcelInfoApiData.addedBy = addedBy;
  }
  final String? receiverName =
      jsonConvert.convert<String>(json['receiverName']);
  if (receiverName != null) {
    parcelInfoApiData.receiverName = receiverName;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    parcelInfoApiData.type = type;
  }
  final String? parcelSize = jsonConvert.convert<String>(json['parcelSize']);
  if (parcelSize != null) {
    parcelInfoApiData.parcelSize = parcelSize;
  }
  final String? parcelWeight =
      jsonConvert.convert<String>(json['parcelWeight']);
  if (parcelWeight != null) {
    parcelInfoApiData.parcelWeight = parcelWeight;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    parcelInfoApiData.status = status;
  }
  final String? deliveryType =
      jsonConvert.convert<String>(json['deliveryType']);
  if (deliveryType != null) {
    parcelInfoApiData.deliveryType = deliveryType;
  }
  return parcelInfoApiData;
}

Map<String, dynamic> $ParcelInfoApiDataToJson(ParcelInfoApiData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['senderName'] = entity.senderName;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  data['senderContact'] = entity.senderContact;
  data['receiverContact'] = entity.receiverContact;
  data['addedBy'] = entity.addedBy;
  data['receiverName'] = entity.receiverName;
  data['type'] = entity.type;
  data['parcelSize'] = entity.parcelSize;
  data['parcelWeight'] = entity.parcelWeight;
  data['status'] = entity.status;
  data['deliveryType'] = entity.deliveryType;
  return data;
}
