import 'package:insertion_app/generated/json/base/json_convert_content.dart';
import 'package:insertion_app/apiClasses/OSM_API_CLASS_entity.dart';

OSMAPICLASSEntity $OSMAPICLASSEntityFromJson(Map<String, dynamic> json) {
  final OSMAPICLASSEntity oSMAPICLASSEntity = OSMAPICLASSEntity();
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    oSMAPICLASSEntity.type = type;
  }
  final String? licence = jsonConvert.convert<String>(json['licence']);
  if (licence != null) {
    oSMAPICLASSEntity.licence = licence;
  }
  final List<OSMAPICLASSFeatures>? features =
      jsonConvert.convertListNotNull<OSMAPICLASSFeatures>(json['features']);
  if (features != null) {
    oSMAPICLASSEntity.features = features;
  }
  return oSMAPICLASSEntity;
}

Map<String, dynamic> $OSMAPICLASSEntityToJson(OSMAPICLASSEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['licence'] = entity.licence;
  data['features'] = entity.features.map((v) => v.toJson()).toList();
  return data;
}

OSMAPICLASSFeatures $OSMAPICLASSFeaturesFromJson(Map<String, dynamic> json) {
  final OSMAPICLASSFeatures oSMAPICLASSFeatures = OSMAPICLASSFeatures();
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    oSMAPICLASSFeatures.type = type;
  }
  final OSMAPICLASSFeaturesProperties? properties =
      jsonConvert.convert<OSMAPICLASSFeaturesProperties>(json['properties']);
  if (properties != null) {
    oSMAPICLASSFeatures.properties = properties;
  }
  final List<double>? bbox =
      jsonConvert.convertListNotNull<double>(json['bbox']);
  if (bbox != null) {
    oSMAPICLASSFeatures.bbox = bbox;
  }
  final OSMAPICLASSFeaturesGeometry? geometry =
      jsonConvert.convert<OSMAPICLASSFeaturesGeometry>(json['geometry']);
  if (geometry != null) {
    oSMAPICLASSFeatures.geometry = geometry;
  }
  return oSMAPICLASSFeatures;
}

Map<String, dynamic> $OSMAPICLASSFeaturesToJson(OSMAPICLASSFeatures entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['properties'] = entity.properties.toJson();
  data['bbox'] = entity.bbox;
  data['geometry'] = entity.geometry.toJson();
  return data;
}

OSMAPICLASSFeaturesProperties $OSMAPICLASSFeaturesPropertiesFromJson(
    Map<String, dynamic> json) {
  final OSMAPICLASSFeaturesProperties oSMAPICLASSFeaturesProperties =
      OSMAPICLASSFeaturesProperties();
  final int? placeId = jsonConvert.convert<int>(json['place_id']);
  if (placeId != null) {
    oSMAPICLASSFeaturesProperties.placeId = placeId;
  }
  final String? osmType = jsonConvert.convert<String>(json['osm_type']);
  if (osmType != null) {
    oSMAPICLASSFeaturesProperties.osmType = osmType;
  }
  final int? osmId = jsonConvert.convert<int>(json['osm_id']);
  if (osmId != null) {
    oSMAPICLASSFeaturesProperties.osmId = osmId;
  }
  final String? displayName = jsonConvert.convert<String>(json['display_name']);
  if (displayName != null) {
    oSMAPICLASSFeaturesProperties.displayName = displayName;
  }
  final int? placeRank = jsonConvert.convert<int>(json['place_rank']);
  if (placeRank != null) {
    oSMAPICLASSFeaturesProperties.placeRank = placeRank;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    oSMAPICLASSFeaturesProperties.category = category;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    oSMAPICLASSFeaturesProperties.type = type;
  }
  final double? importance = jsonConvert.convert<double>(json['importance']);
  if (importance != null) {
    oSMAPICLASSFeaturesProperties.importance = importance;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    oSMAPICLASSFeaturesProperties.icon = icon;
  }
  return oSMAPICLASSFeaturesProperties;
}

Map<String, dynamic> $OSMAPICLASSFeaturesPropertiesToJson(
    OSMAPICLASSFeaturesProperties entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['place_id'] = entity.placeId;
  data['osm_type'] = entity.osmType;
  data['osm_id'] = entity.osmId;
  data['display_name'] = entity.displayName;
  data['place_rank'] = entity.placeRank;
  data['category'] = entity.category;
  data['type'] = entity.type;
  data['importance'] = entity.importance;
  data['icon'] = entity.icon;
  return data;
}

OSMAPICLASSFeaturesGeometry $OSMAPICLASSFeaturesGeometryFromJson(
    Map<String, dynamic> json) {
  final OSMAPICLASSFeaturesGeometry oSMAPICLASSFeaturesGeometry =
      OSMAPICLASSFeaturesGeometry();
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    oSMAPICLASSFeaturesGeometry.type = type;
  }
  final List<double>? coordinates =
      jsonConvert.convertListNotNull<double>(json['coordinates']);
  if (coordinates != null) {
    oSMAPICLASSFeaturesGeometry.coordinates = coordinates;
  }
  return oSMAPICLASSFeaturesGeometry;
}

Map<String, dynamic> $OSMAPICLASSFeaturesGeometryToJson(
    OSMAPICLASSFeaturesGeometry entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['coordinates'] = entity.coordinates;
  return data;
}
