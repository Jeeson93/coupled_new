class SMCItem {
  String type = '';
  List country = [];
  List state = [];
  List city = [];

  SMCItem.fromJson(type, Map<String, dynamic> json) {
    switch (type) {
      case 'country':
        print(json['status']);
        country = (json['response'] as List)
            .map((e) => null == e
                ? 'Country'
                : Countries.fromJson(e as Map<String, dynamic>))
            .toList();
        break;
      case 'state':
        state = (json['response'])
            .map((e) => e == null
                ? 'State'
                : States.fromJson(e as Map<String, dynamic>))
            ?.toList();
        break;
      case 'city':
        city = (json['response'])
            .map((e) =>
                e == null ? 'City' : Cities.fromJson(e as Map<String, dynamic>))
            .toList();
        break;
    }
    this.type = type;
  }

  SMCItem(
      {required this.type,
      required this.country,
      required this.state,
      required this.city});

  @override
  String toString() {
    return 'SMCItem{type: $type, country: $country, state: $state, city: $city}';
  }
}

class Countries {
  int id = 0;
  String name = '';
  String code = '';

  Countries({this.id = 0, this.name = '', this.code = ''});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }

  @override
  String toString() {
    return 'Countries{id: $id, name: $name, code: $code}';
  }
}

class States {
  int id = 0;
  String countryCode = '';
  String zipcode = '';
  String locality = '';
  String state = '';
  String stateCode = '';
  String district = '';
  String districtCode = '';
  String taluk = '';
  String logitude = '';
  String latitude = '';

  States(
      {this.id = 0,
      this.countryCode = '',
      this.zipcode = '',
      this.locality = '',
      this.state = '',
      this.stateCode = '',
      this.district = '',
      this.districtCode = '',
      this.taluk = '',
      this.logitude = '',
      this.latitude = ''});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['country_code'];
    zipcode = json['zipcode'];
    locality = json['locality'];
    state = json['state'];
    stateCode = json['state_code'];
    district = json['district'];
    districtCode = json['district_code'];
    taluk = json['taluk'];
    logitude = json['logitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['country_code'] = this.countryCode;
    data['zipcode'] = this.zipcode;
    data['locality'] = this.locality;
    data['state'] = this.state;
    data['state_code'] = this.stateCode;
    data['district'] = this.district;
    data['district_code'] = this.districtCode;
    data['taluk'] = this.taluk;
    data['logitude'] = this.logitude;
    data['latitude'] = this.latitude;
    return data;
  }

  @override
  String toString() {
    return 'States{id: $id, countryCode: $countryCode, zipcode: $zipcode, locality: $locality, state: $state, stateCode: $stateCode, district: $district, districtCode: $districtCode, taluk: $taluk, logitude: $logitude, latitude: $latitude}';
  }
}

class Cities {
  int id = 0;
  String countryCode = '';
  String zipcode = '';
  String locality = '';
  String state = '';
  String stateCode = '';
  String district = '';
  String districtCode = '';
  String taluk = '';
  String logitude = '';
  String latitude = '';

  Cities(
      {this.id = 0,
      this.countryCode = '',
      this.zipcode = '',
      this.locality = '',
      this.state = '',
      this.stateCode = '',
      this.district = '',
      this.districtCode = '',
      this.taluk = '',
      this.logitude = '',
      this.latitude = ''});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['country_code'];
    zipcode = json['zipcode'];
    locality = json['locality'];
    state = json['state'];
    stateCode = json['state_code'];
    district = json['district'];
    districtCode = json['district_code'];
    taluk = json['taluk'];
    logitude = json['logitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['country_code'] = this.countryCode;
    data['zipcode'] = this.zipcode;
    data['locality'] = this.locality;
    data['state'] = this.state;
    data['state_code'] = this.stateCode;
    data['district'] = this.district;
    data['district_code'] = this.districtCode;
    data['taluk'] = this.taluk;
    data['logitude'] = this.logitude;
    data['latitude'] = this.latitude;
    return data;
  }

  @override
  String toString() {
    return 'Cities{id: $id, countryCode: $countryCode, zipcode: $zipcode, locality: $locality, state: $state, stateCode: $stateCode, district: $district, districtCode: $districtCode, taluk: $taluk, logitude: $logitude, latitude: $latitude}';
  }
}
