import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/match_maker_page.dart';
import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:coupled/registration_new/helpers/get_baseSettings.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

class MatchMakerProvider extends InheritedWidget {
  final MatchMakerModel matchMakerModel;
  final List<BaseSettings> baseSettings;
  final CounterBloc counterBloc;
  final bool maxFilterReached;
  final BuildContext context;
  final bool isCouplingQues;

  MatchMakerProvider({
    Key? key,
    required this.context,
    required this.matchMakerModel,
    required this.baseSettings,
    this.maxFilterReached = false,
    required this.counterBloc,
    required Widget child,
    this.isCouplingQues = false,
  })  : assert(child != null),
        super(key: key, child: child);

  static MatchMakerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(
        aspect: MatchMakerProvider);
  }

  @override
  bool updateShouldNotify(MatchMakerProvider oldWidget) {
    return oldWidget.matchMakerModel != matchMakerModel ||
        oldWidget.baseSettings != baseSettings;
  }

  bool chkMaxFilterReached(bool value) {
    print("runtimeType : ${context.findAncestorStateOfType()}");
    bool v = false;
    if (value && !maxFilterReached) {
      counterBloc.add(CounterEvent(true));
      v = true;
    } else if (!value) {
      counterBloc.add(CounterEvent(false));
      v = false;
    } else {
      print(
          "chkMaxFilterReached matchMakerModel ::${matchMakerModel.toJson()}");
      if (matchMakerModel.matchType.toLowerCase() == 'general_match')
        Dialogs().showSimpleMessageDialog(context,
            msg: CoupledStrings.matchMakerMaxWarning(
                matchMakerModel.generalCount),
            title: 'Sorry');
      else if (matchMakerModel.matchType.toLowerCase() == 'mix_match') {
        Dialogs().showSimpleMessageDialog(context,
            msg: CoupledStrings.matchMakerMaxWarning(matchMakerModel.mixCount),
            title: 'Sorry');
      } else if (matchMakerModel.matchType.toLowerCase() == 'coupling_match') {
        Dialogs().showSimpleMessageDialog(context,
            msg: CoupledStrings.matchMakerMaxWarning(
                matchMakerModel.couplingCount),
            title: 'Sorry');
      }
      v = false;
    }
    print("chkMaxFilterReached ::  $v $maxFilterReached  $value");
    return v;
  }

  void setPersonalDetails({
    String type = '',
    required List listItems,
    MatchMakerModel? matchmaker,
    Function? isChecked,
    List<BaseSettings>? baseSettings,
  }) {
    BaseSettings baseSettingsList =
        getBaseSettingsByType(type, GlobalData.baseSettings);
    if (baseSettingsList != null) {
      baseSettingsList.options!.forEach((f) {
        listItems.add(listItems is List<WrapItem>
            ? WrapItem(isSelected: false, title: f.value, id: f.id.toString())
            : Item(id: f.id.toString(), name: f.value));

        /* listItems.add(T is WrapItem
            ? WrapItem(isSelected: false, title: f.value, id: f.id.toString())
            : Item(id: f.id.toString(), name: f.value));*/
      });
    }
    if (matchmaker != null) {
      switch (type) {
        case CoupledStrings.baseSettingsBodyType:
          isChecked!(matchmaker.bodyType.length > 0);
          listItems.forEach((items) {
            matchmaker.bodyType.forEach((bodyType) {
              if (items is WrapItem && items.id == bodyType) {
                items.isSelected = true;
              }
            });
          });
          break;
        case CoupledStrings.baseSettingsComplexion:
          isChecked!(matchmaker.complexion.length > 0);
          listItems.forEach((items) {
            matchmaker.complexion.forEach((complexion) {
              if (items is WrapItem && items.id == complexion) {
                items.isSelected = true;
              }
            });
          });
          break;
        case CoupledStrings.baseSettingsMaritalStatus:
          isChecked!(matchmaker.maritalStatus.length > 0);
          listItems.forEach((items) {
            matchmaker.maritalStatus.forEach((marital) {
              if (items is WrapItem && items.id == marital) {
                items.isSelected = true;
              }
            });
          });
          break;
        case CoupledStrings.baseSettingsFamilyType:
          isChecked!(matchmaker.familyType.length > 0);
          listItems.forEach((items) {
            matchmaker.familyType.forEach((familyType) {
              if (items is WrapItem && items.id == familyType) {
                items.isSelected = true;
              }
            });
          });
          break;
        case CoupledStrings.baseSettingsFamilyValue:
          isChecked!(matchmaker.familyValues.length > 0);
          listItems.forEach((items) {
            matchmaker.familyValues.forEach((familyValue) {
              if (items is WrapItem && items.id == familyValue) {
                items.isSelected = true;
              }
            });
          });
          break;
        case CoupledStrings.baseSettingsIncome:
          isChecked!(matchmaker.income.length > 0);
          print("METER : ${matchmaker.income}");
          listItems.forEach((items) {
            matchmaker.income.forEach((income) {
              if (items is WrapItem && items.id == income) {
                items.isSelected = true;
              }
            });
          });
          break;
        case CoupledStrings.baseSettingsIndustry:
          isChecked!(matchmaker.occupation.length > 0);
          print("METER : ${matchmaker.occupation}");
          listItems.forEach((items) {
            matchmaker.occupation.forEach((income) {
              if (items is WrapItem && items.id == income) {
                items.isSelected = true;
              }
            });
          });
          break;
        case CoupledStrings.baseSettingsEdu:
          isChecked!(matchmaker.education.length > 0);
          print("METER : ${matchmaker.education}");
          listItems.forEach((items) {
            matchmaker.education.forEach((income) {
              if (items is WrapItem && items.id == income) {
                items.isSelected = true;
              }
            });
          });
          break;
      }
    }
  }
}
