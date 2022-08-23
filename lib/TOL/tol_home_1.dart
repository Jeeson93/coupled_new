import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/TOL/Bloc/tol_list_bloc_bloc.dart';
import 'package:coupled/TOL/tol_checkout.dart';
import 'package:coupled/TOL/tol_helpers.dart';
import 'package:coupled/TOL/tol_item_2.dart';
import 'package:coupled/TOL/tol_order_3.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TOLHome extends StatefulWidget {
  @override
  _TOLHomeState createState() => _TOLHomeState();
}

class _TOLHomeState extends State<TOLHome> {
  // List<TolCategory> tolCategory = [];
  // List<TolCategory> tolSort = [];

  TolListBlocBloc tolListBlocBloc = TolListBlocBloc();
  List<Datum> listDatum = [];

  @override
  void initState() {
    GlobalData.selectedCategory = BaseSettings(value: 'Category', options: []);
    GlobalData.selectedSort = BaseSettings(value: 'Sort', options: []);
    tolListBlocBloc = BlocProvider.of<TolListBlocBloc>(context);
    tolListBlocBloc.add(TolListLoadEvent());
    listDatum.add(
      Datum(
          membershipCode: GlobalData.chatResponse != null
              ? GlobalData.chatResponse?.partner?.membershipCode
              : GlobalData?.othersProfile.membershipCode,
          info: GlobalData?.chatResponse?.partner?.info != null
              ? GlobalData?.chatResponse?.partner?.info
              : GlobalData?.othersProfile.info,
          name: GlobalData.chatResponse?.partner?.name != null
              ? GlobalData.chatResponse?.partner?.name
              : GlobalData?.othersProfile.name,
          lastName: GlobalData.chatResponse?.partner?.lastName != null
              ? GlobalData.chatResponse?.partner?.lastName
              : GlobalData?.othersProfile.lastName,
          dp: GlobalData.chatResponse?.partner?.dp != null
              ? GlobalData.chatResponse?.partner?.dp
              : GlobalData?.othersProfile.dp,
          membership: Membership(paidMember: false),
          officialDocuments: OfficialDocuments(),
          purchasePlan: Plan(topups: [])),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoupledTheme().backgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  'Token of Love',
                  size: 20,
                  color: CoupledTheme().primaryBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/profileSwitch',
                        arguments: ProfileSwitch(
                          userShortInfoModel: UserShortInfoModel(
                              response: UserShortInfoResponse(
                            data: listDatum,
                          )),
                          memberShipCode: GlobalData.chatResponse != null
                              ? GlobalData.chatResponse?.partner?.membershipCode
                              : "",
                        ));
                  },
                  child: TextView(
                    '${GlobalData?.chatResponse != null ? GlobalData.chatResponse?.partner?.name : ''}',
                    size: 14,
                    color: CoupledTheme().primaryPink,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                )
              ],
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TolOrders()));
              },
              child: Image.asset(
                'assets/TOL/package_variant.png',
                width: 30,
              )),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      backgroundColor: CoupledTheme().backgroundColor,
      body: BlocBuilder(
        bloc: tolListBlocBloc,
        builder: (context, TolListBlocState state) {
          print('tol state ============= $state');
          print(GlobalData.tolProducts);
          if (state is InitialTolListBlocState) {
            return Center(child: GlobalWidgets().showCircleProgress());
          }
          /*else if (state is TolErrorState) {
            return Center(
                child: GlobalWidgets().errorState(message: state.errorMessage));
          }*/
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              topBar(context, tolListBlocBloc),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                      GlobalData?.tolProducts.response?.data?.length ?? 0,
                      (index) {
                    return buildCard(
                      index,
                      context,
                    );
                  }),
                  childAspectRatio: .7,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

///tol home items card
Widget buildCard(int index, BuildContext context) {
  return Column(
    children: <Widget>[
      Expanded(
        flex: 8,
        child: GestureDetector(
          onTap: () {
            GlobalData.selectedItem =
                GlobalData.tolProducts.response!.data![index];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TolItem(
                    // index: index,
                    ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            clipBehavior: Clip.antiAlias,
            elevation: 3.0,
            child: Stack(
              children: <Widget>[
                FadeInImage.assetNetwork(
                  width: MediaQuery.of(context).size.width,
                  height: (72 * MediaQuery.of(context).size.height) / 100,
                  fit: BoxFit.cover,
                  placeholder: 'assets/no_image.jpg',
                  image: APis().imageApi(
                      GlobalData
                          .tolProducts.response?.data![index].image?.imageName,
                      imageFolder: ImageFolder.TOL),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 6,
                  child: TextView(
                    GlobalData.tolProducts.response!.data![index].name,
                    size: 16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: CoupledTheme().primaryBlue,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  )),
              Expanded(
                flex: 4,
                child: TextView(
                  '${CoupledStrings.INR} ${GlobalData.tolProducts.response!.data![index].price}',
                  size: 16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  color: CoupledTheme().primaryBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  textScaleFactor: .8,
                ),
              ),
            ],
          )),
      SizedBox(
        height: 5,
      ),
      Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QuantityButton(index: index),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  flex: 3,
                  child: CustomButton(
                    child: Expanded(
                      child: Center(
                        child: TextView(
                          'Buy',
                          maxLines: 1,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                          color: Colors.white,
                          overflow: TextOverflow.visible,
                          size: 12,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(0),
                    onPressed: () {
                      GlobalData.selectedItem =
                          GlobalData.tolProducts.response!.data![index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TolCheckOut(
                              //  items: tolItems,
                              ),
                        ),
                      );
                    },
                  ))
            ],
          )),
      SizedBox(
        height: 15,
      ),
    ],
  );
}
