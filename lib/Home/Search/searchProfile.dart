import 'package:coupled/Home/MatchBoard/MatchBoardView.dart';
import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';
import 'package:coupled/Home/Search/bloc/bloc.dart';
import 'package:coupled/Home/Search/bloc/search_bloc.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchAction extends SearchDelegate<String> {
  final SearchBloc searchBloc;
  bool debounceActive = false;
  String _prevQuery = "";
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  SearchAction({String searchFieldLabel = '', required this.searchBloc})
      : super(searchFieldLabel: searchFieldLabel);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = ThemeData(
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: CoupledTheme().defaultTextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            lineSpacing: 0.0,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center),
      ),
    );
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: GlobalWidgets().iconCreator("assets/MatchBoard/Close.png",
            color: Colors.white, size: FixedIconSize.SMALL),
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: GlobalWidgets().iconCreator(
            "assets/MatchBoard/Advanced-Search.png",
            color: Colors.white,
            size: FixedIconSize.MEDIUM),
        onPressed: () {
          Navigator.pushNamed(context, "/advancedSearch");
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 18.0,
        onPressed: () {
          close(context, '');
        });
  }

  searchQuery(limit) async {
    _prevQuery = query;
    print("kury");
    print(query);
    // print("SearchBloc :::: ${await searchBloc.isEmpty}");
    if (query.length >= 3) {
      if (debounceActive) return null;
      debounceActive = true;
      await Future.delayed(Duration(milliseconds: 700));
      debounceActive = false;
      searchBloc.add(SearchQuery({"query": query, "limit": limit}));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('search_key', query);
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    if (_prevQuery != query) searchQuery("");
    return buildView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (_prevQuery != query) searchQuery(10);
    return buildView();
  }

  Widget buildView() {
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      body: StatefulBuilder(builder: (context, setState) {
        return BlocBuilder<SearchBloc, SearchState>(
            bloc: searchBloc,
            builder: (context, state) {
              print('state-----------');
              print(state);
              if (query.length < 3)
                return ListTile(
                  title: TextView(
                    "Search term must be longer than two letters.",
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                );

              if (state is InitialSearchState) {
                return ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextView(
                          "Searching...",
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          textScaleFactor: 1,
                          size: 14,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: GlobalWidgets().showCircleProgress(),
                        )
                      ]),
                );
              } else if (state is SearchResponse) {
                UserShortInfoResponse? _userShortInfoModelResponse =
                    state.userShortInfoModel.response;
                RegExp re = RegExp(".*[0-9].*");
                bool searchingById = re.hasMatch(query);
                print("searchingById ::: $searchingById    $query   $re");
                print(_userShortInfoModelResponse?.data![0].dp?.photoName);
                return ListView.builder(
                  itemCount: _userShortInfoModelResponse?.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print("QUERY : $query");
                        print('userShortInfoModels---');
                        print(_userShortInfoModelResponse?.data![index].name);
                        if (searchingById) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OthersProfile(
                                membershipCode: _userShortInfoModelResponse
                                    ?.data![index]?.membershipCode,
                                offset: 0,
                                profileResponse: ProfileResponse(
                                    name: _userShortInfoModelResponse
                                        ?.data![index].name,
                                    lastName: _userShortInfoModelResponse
                                        ?.data![index].lastName,
                                    membershipCode: _userShortInfoModelResponse
                                        ?.data![index].membershipCode,
                                    info: _userShortInfoModelResponse
                                        ?.data![index].info,
                                    officialDocuments:
                                        _userShortInfoModelResponse
                                            ?.data![index].officialDocuments,
                                    // dp: element.dp,
                                    photos: [
                                      _userShortInfoModelResponse
                                          ?.data![index].dp
                                    ],
                                    usersBasicDetails: UsersBasicDetails(),
                                    mom: Mom(),
                                    preference: Preference(
                                        complexion: BaseSettings(options: [])),
                                    address: Address(),
                                    photoData: [],
                                    family: Family(
                                        fatherOccupationStatus:
                                            BaseSettings(options: []),
                                        cast: BaseSettings(options: []),
                                        familyType: BaseSettings(options: []),
                                        familyValues: BaseSettings(options: []),
                                        gothram: BaseSettings(options: []),
                                        motherOccupationStatus:
                                            BaseSettings(options: []),
                                        religion: BaseSettings(options: []),
                                        subcast: BaseSettings(options: [])),
                                    educationJob: EducationJob(
                                        educationBranch:
                                            BaseSettings(options: []),
                                        experience: BaseSettings(options: []),
                                        highestEducation:
                                            BaseSettings(options: []),
                                        incomeRange: BaseSettings(options: []),
                                        industry: BaseSettings(options: []),
                                        profession: BaseSettings(options: [])),
                                    membership: Membership.fromMap({}),
                                    userCoupling: [],
                                    dp: Dp(
                                        photoName: '',
                                        imageType: BaseSettings(options: []),
                                        imageTaken: BaseSettings(options: []),
                                        userDetail: UserDetail(
                                            membership:
                                                Membership(paidMember: false))),
                                    blockMe: Mom(),
                                    reportMe: Mom(),
                                    freeCoupling: [],
                                    recomendCause: [],
                                    shortlistByMe: Mom(),
                                    shortlistMe: Mom(),
                                    photoModel: PhotoModel(),
                                    currentCsStatistics: CurrentCsStatistics(),
                                    siblings: []),
                              ),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MatchBoardView(
                                setAppBar:
                                    "${_userShortInfoModelResponse?.data![index].name} ${_userShortInfoModelResponse?.data![index].lastName?.substring(0, 1)?.toString() ?? ''}",
                                searchQuery: query,
                                index: 0,
                                userShortInfoModelList: [
                                  state.userShortInfoModel
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      leading: searchingById
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(APis().imageApi(
                                  _userShortInfoModelResponse
                                          ?.data![index].dp?.photoName ??
                                      '',
                                  //imageSize: 200,
                                  imageConversion: ImageConversion.MEDIA)),
                            )
                          : Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                      title: TextView(
                        "${_userShortInfoModelResponse?.data![index].name.toString()} ${_userShortInfoModelResponse?.data![index].lastName?.substring(0, 1).toString()}" +
                            '\n' +
                            "${searchingById ? _userShortInfoModelResponse?.data![index].membershipCode.toString() : ''} ",
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        textScaleFactor: 1,
                        size: 14,
                      ),
                    );
                  },
                );
              }

              return ListTile(
                title: TextView(
                  "No search result founds",
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
              );
            });
      }),
    );
  }
}

class TheSearch extends SearchDelegate<String> {
  TheSearch({required this.contextPage});

  BuildContext contextPage;
  final suggestions1 = ["https://www.google.com"];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = ThemeData(
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: CoupledTheme().defaultTextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          lineSpacing: 0.0,
        ),
      ),
    );
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: GlobalWidgets().iconCreator("assets/MatchBoard/Close.png",
            color: Colors.white, size: FixedIconSize.SMALL),
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: GlobalWidgets().iconCreator(
            "assets/MatchBoard/Advanced-Search.png",
            color: Colors.white,
            size: FixedIconSize.MEDIUM),
        onPressed: () {
          Navigator.pushNamed(context, "/advancedSearch");
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 18.0,
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    print("object");
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("object");
    return Container(
      child: TextView(
        "text",
        color: Colors.white,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
      ),
    );
  }
}
