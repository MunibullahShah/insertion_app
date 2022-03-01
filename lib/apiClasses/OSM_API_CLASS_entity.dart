import 'dart:convert';
import 'package:insertion_app/generated/json/base/json_field.dart';
import 'package:insertion_app/generated/json/OSM_API_CLASS_entity.g.dart';

@JsonSerializable()
class OSMAPICLASSEntity {
  late String type;
  late String licence;
  late List<OSMAPICLASSFeatures> features;

  OSMAPICLASSEntity();

  factory OSMAPICLASSEntity.fromJson(Map<String, dynamic> json) =>
      $OSMAPICLASSEntityFromJson(json);

  Map<String, dynamic> toJson() => $OSMAPICLASSEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OSMAPICLASSFeatures {
  late String type;
  late OSMAPICLASSFeaturesProperties properties;
  late List<double> bbox;
  late OSMAPICLASSFeaturesGeometry geometry;

  OSMAPICLASSFeatures();

  factory OSMAPICLASSFeatures.fromJson(Map<String, dynamic> json) =>
      $OSMAPICLASSFeaturesFromJson(json);

  Map<String, dynamic> toJson() => $OSMAPICLASSFeaturesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OSMAPICLASSFeaturesProperties {
  @JSONField(name: "place_id")
  late int placeId;
  @JSONField(name: "osm_type")
  late String osmType;
  @JSONField(name: "osm_id")
  late int osmId;
  @JSONField(name: "display_name")
  late String displayName;
  @JSONField(name: "place_rank")
  late int placeRank;
  late String category;
  late String type;
  late double importance;
  late String icon;

  OSMAPICLASSFeaturesProperties();

  factory OSMAPICLASSFeaturesProperties.fromJson(Map<String, dynamic> json) =>
      $OSMAPICLASSFeaturesPropertiesFromJson(json);

  Map<String, dynamic> toJson() => $OSMAPICLASSFeaturesPropertiesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OSMAPICLASSFeaturesGeometry {
  late String type;
  late List<double> coordinates;

  OSMAPICLASSFeaturesGeometry();

  factory OSMAPICLASSFeaturesGeometry.fromJson(Map<String, dynamic> json) =>
      $OSMAPICLASSFeaturesGeometryFromJson(json);

  Map<String, dynamic> toJson() => $OSMAPICLASSFeaturesGeometryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
