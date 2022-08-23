import 'package:coupled/models/base_settings_model.dart';

BaseSettings getBaseSettingsByType(type, List<BaseSettings> baseSettings) {
  return baseSettings.singleWhere((test) {
    return test.value == type;
  }, orElse: () => type);
}

List<BaseSettings>? getBaseSettingsOptionsByType(
    type, List<BaseSettings>? baseSettings) {
  return baseSettings!
      .singleWhere((test) => test.value == type,
          orElse: () => BaseSettings(options: []))
      .options;
}
