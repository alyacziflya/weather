class SuggestCityModel {
  SuggestCityModel({
    List<Data>? data,
    Metadata? metadata,}){
    _data = data;
    _metadata = metadata;
  }

  SuggestCityModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }
  List<Data>? _data;
  Metadata? _metadata;

  List<Data>? get data => _data;
  Metadata? get metadata => _metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_metadata != null) {
      map['metadata'] = _metadata?.toJson();
    }
    return map;
  }

}

class Metadata {
  Metadata({
    int? currentOffset,
    int? totalCount,}){
    _currentOffset = currentOffset;
    _totalCount = totalCount;
  }

  Metadata.fromJson(dynamic json) {
    _currentOffset = json['currentOffset'];
    _totalCount = json['totalCount'];
  }
  int? _currentOffset;
  int? _totalCount;

  int? get currentOffset => _currentOffset;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentOffset'] = _currentOffset;
    map['totalCount'] = _totalCount;
    return map;
  }

}

class Data {
  Data({
    int? id,
    String? wikiDataId,
    String? type,
    String? city,
    String? name,
    String? country,
    String? countryCode,
    String? region,
    String? regionCode,
    double? latitude,
    double? longitude,
  }){
    _id = id;
    _wikiDataId = wikiDataId;
    _type = type;
    _city = city;
    _name = name;
    _country = country;
    _countryCode = countryCode;
    _region = region;
    _regionCode = regionCode;
    _latitude = latitude;
    _longitude = longitude;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _wikiDataId = json['wikiDataId'];
    _type = json['type'];
    _city = json['city'];
    _name = json['name'];
    _country = json['country'];
    _countryCode = json['countryCode'];
    _region = json['region'];
    _regionCode = json['regionCode'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  int? _id;
  String? _wikiDataId;
  String? _type;
  String? _city;
  String? _name;
  String? _country;
  String? _countryCode;
  String? _region;
  String? _regionCode;
  double? _latitude;
  double? _longitude;

  int? get id => _id;
  String? get wikiDataId => _wikiDataId;
  String? get type => _type;
  String? get city => _city;
  String? get name => _name;
  String? get country => _country;
  String? get countryCode => _countryCode;
  String? get region => _region;
  String? get regionCode => _regionCode;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['wikiDataId'] = _wikiDataId;
    map['type'] = _type;
    map['city'] = _city;
    map['name'] = _name;
    map['country'] = _country;
    map['countryCode'] = _countryCode;
    map['region'] = _region;
    map['regionCode'] = _regionCode;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}