class BaseSettingsModel {
  dynamic status;
  dynamic baseSettings;

  BaseSettingsModel({this.status, this.baseSettings});

  BaseSettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['response'] != null) {
      baseSettings = <BaseSettings>[];
      json['response'].forEach((v) {
        baseSettings.add(BaseSettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.baseSettings != null) {
      data['response'] = this.baseSettings.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BaseSettingsModel{status: $status, response: $baseSettings}';
  }
}

class BaseSettings {
  dynamic isSelected = false;
  dynamic id;
  dynamic type;
  String value = '';
  dynamic parentId;
  dynamic others = '';
  dynamic status;
  dynamic checked = false;
  List<BaseSettings>? options;

  BaseSettings(
      {this.id,
      this.type,
      this.value = '',
      this.parentId,
      this.others = '',
      this.status,
      required this.options,
      this.checked,
      this.isSelected = false});

  BaseSettings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'] != null ? json['value'] : '';
    parentId = json['parent_id'];
    others = json['others'] != null ? json['others'] : '';
    status = json['status'];
    if (json['options'] != null) {
      options = <BaseSettings>[];
      json['options'].forEach((v) {
        options!.add(BaseSettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['value'] = this.value;
    data['parent_id'] = this.parentId;
    data['others'] = this.others;
    data['status'] = this.status;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BaseSettings{id: $id, type: $type, value: $value, parentId: $parentId, others: $others, status: $status, options: $options}';
  }
}
