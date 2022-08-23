part of 'smc_bloc.dart';

abstract class SmcEvent extends Equatable {
  SmcEvent([List props = const []]) : super();
}

class SMCParams extends SmcEvent {
  final String type;
  final String countryCode;
  final String stateCode;
  final String search;

  SMCParams(
      {this.type = "country",
      this.countryCode = '',
      this.stateCode = '',
      this.search = ''})
      : super([type, countryCode, stateCode, search]);

  Map<String, String> toJson() {
    final Map<String, String> data = Map<String, String>();
    data['type'] = this.type;
    data['country_code'] = this.countryCode;
    data['state_code'] = this.stateCode;
    data['search'] = this.search;
    return data;
  }

  @override
  String toString() {
    return 'SMCParams{type: $type, countryCode: $countryCode, stateCode: $stateCode, search: $search}';
  }

  @override
  List<Object> get props => [type, countryCode, stateCode, search];
}
