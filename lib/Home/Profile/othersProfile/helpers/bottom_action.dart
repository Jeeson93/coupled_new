import 'package:coupled/Home/Profile/othersProfile/helpers/action_buttons.dart';

import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';

import 'package:flutter/material.dart';

import '../bloc/others_profile_bloc.dart';

Widget bottomAction(BuildContext context, OthersProfileBloc othersProfileBloc) {
  return Container(
    height: 75,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          getActionBtn(
              othersProfileBloc: othersProfileBloc,
              context: context,
              type: btnType.REJECT),
          getActionBtn(
            othersProfileBloc: othersProfileBloc,
            context: context,
            type: btnType.SNOOZE,
          ),
          getActionBtn(
              othersProfileBloc: othersProfileBloc,
              context: context,
              type: btnType.ACCEPT),
        ],
      ),
    ),
  );
}
