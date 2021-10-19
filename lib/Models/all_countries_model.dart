class AllCountriesModel {
  AllCountriesModel({
      this.latest, 
      this.locations,});

  AllCountriesModel.fromJson(dynamic json) {
    latest = json['latest'] != null ? Latest.fromJson(json['latest']) : null;
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations?.add(Locations.fromJson(v));
      });
    }
  }
  Latest? latest;
  List<Locations>? locations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (latest != null) {
      map['latest'] = latest?.toJson();
    }
    if (locations != null) {
      map['locations'] = locations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Locations {
  Locations({
      this.id, 
      this.country, 
      this.countryCode, 
      this.countryPopulation, 
      this.province, 
      this.lastUpdated, 
      this.coordinates, 
      this.latest,});

  Locations.fromJson(dynamic json) {
    id = json['id'];
    country = json['country'];
    countryCode = json['country_code'];
    countryPopulation = json['country_population'];
    province = json['province'];
    lastUpdated = json['last_updated'];
    coordinates = json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null;
    latest = json['latest'] != null ? Latest.fromJson(json['latest']) : null;
  }
  int? id;
  String? country;
  String? countryCode;
  int? countryPopulation;
  String? province;
  String? lastUpdated;
  Coordinates? coordinates;
  Latest? latest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country'] = country;
    map['country_code'] = countryCode;
    map['country_population'] = countryPopulation;
    map['province'] = province;
    map['last_updated'] = lastUpdated;
    if (coordinates != null) {
      map['coordinates'] = coordinates?.toJson();
    }
    if (latest != null) {
      map['latest'] = latest?.toJson();
    }
    return map;
  }

}

class Latest {
  Latest({
      this.confirmed, 
      this.deaths, 
      this.recovered,});

  Latest.fromJson(dynamic json) {
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }
  int? confirmed;
  int? deaths;
  int? recovered;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['confirmed'] = confirmed;
    map['deaths'] = deaths;
    map['recovered'] = recovered;
    return map;
  }

}

class Coordinates {
  Coordinates({
      this.latitude, 
      this.longitude,});

  Coordinates.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}

