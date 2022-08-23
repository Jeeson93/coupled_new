import 'dart:convert';

import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/questions.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

class SingleQuesModal extends StatefulWidget {
  static String route = 'SingleQuesModal';
  final QResponse questions;
  final dynamic index;

  // final Function(List<UserCoupling> selectedValue) selectedValue;

  SingleQuesModal({
    Key? key,
    required this.questions,
    this.index,
    /*this.selectedValue*/
  }) : super(key: key);

  @override
  _SingleQuesModalState createState() => _SingleQuesModalState();
}

class _SingleQuesModalState extends State<SingleQuesModal> {
  int _selectedIndex = -1;
  ProfileResponse? user;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    user = GlobalData.myProfile;
    print("widget.profileResponse ::* ${user?.userCoupling}");
    print("widget.profileResponse :Q:* ${widget.questions}");
    print("widget.user answers :Q:* ${widget.questions.userAnswer}");
    print("userCoupling :Q:* ${user?.userCoupling}");

    ///Previous data loading
    // UserCoupling userCoupling = user?.userCoupling?.singleWhere(
    //         (test) => test.questionId == widget.questions.id,
    //     orElse: () => null);
    // print("::U:: $userCoupling");

    _selectedIndex = widget.questions.answers!.indexWhere((test) =>
        test.id ==
        int.tryParse(Questions.fromMap(
                    GlobalData.couplingQuestion as Map<String, dynamic>)
                .response![widget.index]
                .userAnswer!
                .answer ??
            "0"));

    // if (userCoupling != null) {
    //   _selectedIndex = widget.questions.answers.indexWhere(
    //           (test) => test.id == int.tryParse(userCoupling?.answer ?? "0"));
    //
    //   // _selectedIndex = widget.questions.answers.indexWhere(
    //   //         (test) => test.id == int.tryParse(widget.questions?.userAnswer?.answer ?? "0"));
    //
    //   userCoupling.qType = 'single';
    //   user.userCoupling = [userCoupling];
    //   print("SingleQuesModel :: ${user.userCoupling}");
    //   /* if (_selectedIndex > -1) {
    //     user.questionsInput =
    //         QuestionsInput(questionId: widget.questions.id.toString(), answer: userCoupling.answer);
    //   }*/
    //   for (int i = 0; i < user.userCoupling.length; i++) {
    //     if (user.userCoupling[i].questionId == widget.questions.id) {
    //       print("::U:: ${user.userCoupling[i]}");
    //       _selectedIndex = widget.questions.answers.indexWhere((test) =>
    //       test.id == int.tryParse(user.userCoupling[i]?.answer ?? "0"));
    //       print(":::: $_selectedIndex");
    //     }
    //   }
    // } else {
    //   user.userCoupling = null;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextView(
            widget.questions.question,
            size: 24.0,
            textAlign: TextAlign.start,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textScaleFactor: .8,
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            height: 300.0,
            child: Column(
              children: List<Widget>.generate(widget.questions.answers!.length,
                  (index) {
                return SelectionBox(
                  height: 50.0,
                  child: Center(
                      child: TextView(
                    widget.questions.answers![index].answerOption,
                    textAlign: TextAlign.center,
                    size: 16,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textScaleFactor: .8,
                  )),
                  radius: 5.0,
                  onTap: () {
                    _onSelected(index);
                    print(widget.questions.answers![index].answerOption);
                    int? coupleIndex = user?.userCoupling.indexWhere(
                        (element) => element.questionId == widget.questions.id);
                    print("::coupleIndex:: $coupleIndex");
                    if (coupleIndex != null && coupleIndex > -1) {
                      user?.userCoupling[coupleIndex].answer =
                          widget.questions.answers![index].id.toString();
                    } else {
                      user?.userCoupling = [];
                      user?.userCoupling.add(UserCoupling(
                          questionId: widget.questions.id,
                          answer:
                              widget.questions.answers![index].id.toString()));
                    }
                    user?.userCoupling = [
                      UserCoupling(
                          questionId: widget.questions.id,
                          answer:
                              widget.questions.answers![index].id.toString(),
                          qType: 'single')
                    ];
                    GlobalData.couplingAnswers
                        .add({"question_id": "1", "answer": "1"});

                    ///TODO udayipp code
                    ///adding answers
                    // Questions _questions = Questions.fromMap(GlobalData.couplingQuestion);
                    // _questions.response[widget.index].userAnswer=UserAnswer(answer: '');

                    RestAPI().post('${APis.register}appstepsixteen', params: {
                      "question_id": widget.questions.id,
                      "answer": widget.questions.answers![index].id.toString()
                    }).then((value) {
                      // GlobalData.couplingQuestion =
                      //     await RestAPI().get(APis.getCouplingQuestions);
                      RestAPI().get(APis.getCouplingQuestions).then((value) {
                        setState(() {
                          GlobalData.couplingQuestion = value;
                        });
                      });
                    }, onError: (e) {
                      //GlobalData.couplingQuestion
                      GlobalWidgets().showToast(msg: CoupledStrings.errorMsg);
                    });
                  },
                  innerColor: _selectedIndex != null && _selectedIndex == index
                      ? CoupledTheme().primaryPinkDark
                      : null,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class NestedQuestion extends StatefulWidget {
  final QResponse questions;
  final int index;

  // final Function(List<UserCoupling>) selectedValue;

  NestedQuestion({
    required this.questions,
    this.index = 0,
    //@required this.bloc,
    // this.selectedValue,
  });

  @override
  _NestedQuestionState createState() => _NestedQuestionState();
}

class _NestedQuestionState extends State<NestedQuestion> {
  bool isSelected = false;
  ProfileResponse user = ProfileResponse(
      usersBasicDetails: UsersBasicDetails(),
      mom: Mom(),
      info: Info(
        maritalStatus: BaseSettings(options: []),
      ),
      preference: Preference(complexion: BaseSettings(options: [])),
      officialDocuments: OfficialDocuments(),
      address: Address(),
      photoData: [],
      photos: [],
      family: Family(
          fatherOccupationStatus: BaseSettings(options: []),
          cast: BaseSettings(options: []),
          familyType: BaseSettings(options: []),
          familyValues: BaseSettings(options: []),
          gothram: BaseSettings(options: []),
          motherOccupationStatus: BaseSettings(options: []),
          religion: BaseSettings(options: []),
          subcast: BaseSettings(options: [])),
      educationJob: EducationJob(
          educationBranch: BaseSettings(options: []),
          experience: BaseSettings(options: []),
          highestEducation: BaseSettings(options: []),
          incomeRange: BaseSettings(options: []),
          industry: BaseSettings(options: []),
          profession: BaseSettings(options: [])),
      membership: Membership.fromMap({}),
      userCoupling: [],
      dp: Dp(
          photoName: '',
          imageType: BaseSettings(options: []),
          imageTaken: BaseSettings(options: []),
          userDetail: UserDetail(membership: Membership(paidMember: false))),
      blockMe: Mom(),
      reportMe: Mom(),
      freeCoupling: [],
      recomendCause: [],
      shortlistByMe: Mom(),
      shortlistMe: Mom(),
      photoModel: PhotoModel(),
      currentCsStatistics: CurrentCsStatistics(),
      siblings: []);
  List<_NestedQuestionModal> nestedQuestionModels = [];
  List<_SubQuestionModal> subQuestionModels = [];
  var nestedCouplings = <UserCoupling>[];

  List<Widget> nestedWidget(List<_NestedQuestionModal> nestedQuestionModels) {
    return List.generate(nestedQuestionModels.length, (index) {
      _NestedQuestionModal nestedQuestion = nestedQuestionModels[index];
      return SelectionBox(
          onTap: () {
            setState(() {
              nestedQuestionModels.forEach((data) {
                data.isSelected = false;
              });
              nestedQuestion.isSelected = true;
              print('object');
              print('$nestedQuestion');
              print(nestedQuestion.answers.answerOption);
              int coupleIndex = user.userCoupling.indexWhere(
                  (element) => element.questionId == widget.questions.id);
              int coupleSelectedIndex = nestedCouplings.indexWhere(
                  (element) => element.questionId == widget.questions.id);
              print("::coupleIndex:: $coupleIndex");

              if (coupleIndex != null && coupleIndex > -1) {
                user.userCoupling[coupleIndex].answer =
                    nestedQuestion.answers.id.toString();
                nestedCouplings[coupleSelectedIndex].answer =
                    nestedQuestion.answers.id.toString();
              } else {
                user.userCoupling = [];
                user.userCoupling.add(UserCoupling(
                    questionId: widget.questions.id,
                    answer: nestedQuestion.answers.id.toString()));
                nestedCouplings.add(UserCoupling(
                    questionId: widget.questions.id,
                    answer: nestedQuestion.answers.id.toString(),
                    qType: 'multi'));

                ///if [coupleIndex] is -1 then new list is added in [user.userCoupling] so in that case we need to
                ///re-check the index after adding in [user.userCoupling] to set in the user.getCouplingSection(coupleIndex)]
                ///and call RegisterApi()
                coupleIndex = user.userCoupling.indexWhere(
                    (element) => element.questionId == widget.questions.id);
              }

              ///TODO udayipp code

              ///adding answers
              // Questions _questions = Questions.fromMap(GlobalData.couplingQuestion);
              // _questions.response[widget.index].userAnswer=UserAnswer(answer: '');

              RestAPI().post('${APis.register}appstepsixteen', params: {
                "question_id": widget.questions.id,
                "answer": widget.questions.answers![index].id.toString()
              }).then((value) {
                RestAPI().get(APis.getCouplingQuestions).then((value) {
                  setState(() {
                    GlobalData.couplingQuestion = value;
                  });
                });
              }, onError: (e) {
                GlobalWidgets().showToast(msg: CoupledStrings.errorMsg);
              });

              print("section ::: ${user.userCoupling.length}");

              ///TODO do shit
              //  Section section = Section(whichSection: 16, params: user.getCouplingSection(), profileResponse: user);
              //print("section ::: $section");
              setState(() {
                isSelected = true;
              });
              // _registerBloc.add(RegisterApi(section, 'nested'));
            });
          },
          borderColor:
              nestedQuestion.isSelected ? CoupledTheme().primaryPinkDark : null,
          innerColor:
              nestedQuestion.isSelected ? CoupledTheme().primaryPinkDark : null,
          child: Wrap(
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextView(
                  nestedQuestion.answers.answerOption,
                  textAlign: TextAlign.center,
                  size: 16,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.visible,
                  textScaleFactor: .8,
                ),
              ),
            ],
          ));
    });
  }

  List<Widget> subQuesWidget(List<_SubQuestionModal> subQuestionModels) {
    return List.generate(subQuestionModels.length, (index) {
      _SubQuestionModal subQuestion = subQuestionModels[index];
      return SelectionBox(
          onTap: () {
            setState(() {
              subQuestionModels.forEach((data) {
                data.isSelected = false;
              });
              subQuestion.isSelected = true;
              print(
                  'object::: ${subQuestionModels.where((element) => element.isSelected)}');
              print('$subQuestion');
            });
            print(subQuestion.answers.answerOption);
            int coupleIndex = user.userCoupling.indexWhere((element) =>
                element.questionId == widget.questions.subQuestion!.id);
            int coupleSelectedIndex = nestedCouplings.indexWhere((element) =>
                element.questionId == widget.questions.subQuestion!.id);
            print("::coupleIndex:: $coupleIndex");
            // if (coupleIndex > -1) {
            //   user.userCoupling[coupleIndex].answer =
            //       subQuestion.answers.id.toString();
            //   nestedCouplings[coupleSelectedIndex].answer =
            //       subQuestion.answers.id.toString();
            // } else {
            //   user.userCoupling.add(UserCoupling(
            //       questionId: widget.questions.subQuestion.id,
            //       answer: subQuestion.answers.id.toString()));
            //   nestedCouplings.add(UserCoupling(
            //       questionId: widget.questions.id,
            //       answer: subQuestion.answers.id.toString(),
            //       qType: 'multi'));
            // }
            // print("section ::: ${user.userCoupling.length}");

            ///TODO udayipp code

            ///adding answers
            // Questions _questions = Questions.fromMap(GlobalData.couplingQuestion);
            // _questions.response[widget.index].userAnswer=UserAnswer(answer: '');

            RestAPI().post('${APis.register}appstepsixteen', params: {
              "question_id": widget.questions.subQuestion!.id,
              "answer": subQuestion.answers.id.toString()
            }).then((value) {
              RestAPI().get(APis.getCouplingQuestions).then((value) {
                setState(() {
                  GlobalData.couplingQuestion = value;
                });
              });
            }, onError: (e) {
              GlobalWidgets().showToast(msg: CoupledStrings.errorMsg);
            });
          },
          borderColor:
              subQuestion.isSelected ? CoupledTheme().primaryPinkDark : null,
          innerColor:
              subQuestion.isSelected ? CoupledTheme().primaryPinkDark : null,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextView(
              subQuestion.answers.answerOption,
              textAlign: TextAlign.center,
              size: 16,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textScaleFactor: .8,
            ),
          ));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    user = GlobalData.myProfile;

    print("didChangeDependencies ${widget.questions.answers}");
    // UserCoupling userCoupling = user?.userCoupling?.singleWhere(
    //         (test) => test.questionId == widget.questions.id,
    //     orElse: () => null);

    // _selectedIndex = widget.questions.answers.indexWhere(
    //         (test) => test.id == int.tryParse(widget.questions?.userAnswer?.answer ?? "0"));
    UserCoupling userCoupling = UserCoupling();
    user.userCoupling.forEach((element) {
      if (element.questionId == widget.questions.id) {
        userCoupling = element;
      }
    });

    // print("object :: $userCoupling");
    if (nestedQuestionModels.length == 0) {
      if (true) {
        isSelected = true;
        widget.questions.answers!.forEach((item) {
          nestedQuestionModels.add(_NestedQuestionModal(
              item.id ==
                  int.parse(Questions.fromMap(GlobalData.couplingQuestion
                              as Map<String, dynamic>)
                          .response?[widget.index]
                          .userAnswer
                          ?.answer ??
                      '0'),
              item));
        });
        print("nestedQuestionModels ::: $nestedQuestionModels");
        userCoupling.qType = 'multi';
        nestedCouplings.add(userCoupling);
        //user.userCoupling.addAll(nestedCouplings);
      } else
        user.userCoupling = [];
      widget.questions.answers!.forEach((item) {
        nestedQuestionModels.add(_NestedQuestionModal(false, item));
      });
    }
    // userCoupling = user?.userCoupling?.singleWhere(
    //         (test) => test.questionId == widget.questions.subQuestion.id,
    //     orElse: () => null);
    user.userCoupling.forEach((element) {
      if (element.questionId == widget.questions.subQuestion!.id) {
        userCoupling = element;
      }
    });

    if (subQuestionModels.length == 0) {
      if (true) {
        widget.questions.subQuestion!.answers!.forEach((item) {
          subQuestionModels.add(_SubQuestionModal(
              item.id ==
                  int.parse(Questions.fromMap(GlobalData.couplingQuestion
                              as Map<String, dynamic>)
                          .response?[widget.index]
                          .subQuestion
                          ?.userAnswer
                          ?.answer ??
                      '0'),
              item));
        });
        userCoupling.qType = 'multi';
        nestedCouplings.add(userCoupling);
        //user.userCoupling.addAll(nestedCouplings);
        // ignore: dead_code
      } else {
        user.userCoupling = [];
        widget.questions.subQuestion?.answers?.forEach((item) {
          subQuestionModels.add(_SubQuestionModal(false, item));
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.questions.answers!.length}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              TextView(
                widget.questions.question,
                size: 24.0,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textScaleFactor: .8,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Wrap(children: nestedWidget(nestedQuestionModels)),
              )
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          isSelected
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextView(
                      widget.questions.subQuestion!.question,
                      size: 24.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textScaleFactor: .8,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Wrap(children: subQuesWidget(subQuestionModels)),
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class _NestedQuestionModal {
  bool isSelected;
  Answer answers;

  _NestedQuestionModal(this.isSelected, this.answers);

  @override
  String toString() {
    return '_NestedQuestionModal{isSelected: $isSelected, answers: $answers}';
  }
}

class _SubQuestionModal {
  bool isSelected;
  Answer answers;

  _SubQuestionModal(this.isSelected, this.answers);

  @override
  String toString() {
    return '_SubQuestionModal{isSelected: $isSelected, answers: $answers}';
  }
}

class DragDropModal extends StatefulWidget {
  final dynamic questions;
  final dynamic index;

  // final Function(List<UserCoupling>) selectedValue;

  DragDropModal({
    Key? key,
    this.questions,
    this.index,
    //@required this.bloc,
    // this.selectedValue,
  });

  @override
  DragLists createState() => DragLists();
}

class DragLists extends State<DragDropModal> {
  List<Answer> resetItems = [];
  List<Answer> answerData = [];
  ProfileResponse user = ProfileResponse(
      usersBasicDetails: UsersBasicDetails(),
      mom: Mom(),
      info: Info(maritalStatus: BaseSettings(options: [])),
      preference: Preference(complexion: BaseSettings(options: [])),
      officialDocuments: OfficialDocuments(),
      address: Address(),
      photoData: [],
      photos: [],
      family: Family(
          fatherOccupationStatus: BaseSettings(options: []),
          cast: BaseSettings(options: []),
          familyType: BaseSettings(options: []),
          familyValues: BaseSettings(options: []),
          gothram: BaseSettings(options: []),
          motherOccupationStatus: BaseSettings(options: []),
          religion: BaseSettings(options: []),
          subcast: BaseSettings(options: [])),
      educationJob: EducationJob(
          educationBranch: BaseSettings(options: []),
          experience: BaseSettings(options: []),
          highestEducation: BaseSettings(options: []),
          incomeRange: BaseSettings(options: []),
          industry: BaseSettings(options: []),
          profession: BaseSettings(options: [])),
      membership: Membership.fromMap({}),
      userCoupling: [],
      dp: Dp(
          photoName: '',
          imageType: BaseSettings(options: []),
          imageTaken: BaseSettings(options: []),
          userDetail: UserDetail(membership: Membership(paidMember: false))),
      blockMe: Mom(),
      reportMe: Mom(),
      freeCoupling: [],
      recomendCause: [],
      shortlistByMe: Mom(),
      shortlistMe: Mom(),
      photoModel: PhotoModel(),
      currentCsStatistics: CurrentCsStatistics(),
      siblings: []);
  List<Widget> dragWidget = [];

  List<Widget> dummy(List<Answer> items) {
    //print("Dummy::: $items");

    return dragWidget = List<Widget>.generate(items.length, (index) {
      return SelectionBox(
        key: ValueKey("value$index"),
        radius: 5.0,
        innerColor: CoupledTheme().backgroundColor,
        child: ListTile(
          title: TextView(items[index].answerOption,
              textAlign: TextAlign.left,
              size: 16,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textScaleFactor: .8,
              color: Colors.white),
          leading: Image.asset(
            "assets/ic_hamburger_menu.png",
            height: 15.0,
            width: 15.0,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  void addValue() {
    List<int> result = [];
    answerData.forEach((f) {
      result.add(f.id);
    });
    int coupleIndex = user.userCoupling
        .indexWhere((element) => element.questionId == widget.questions.id);
    print("::coupleIndex:: $coupleIndex");
    if (coupleIndex != null && coupleIndex > -1) {
      user.userCoupling[coupleIndex].answer = json.encode(result);
    } else {
      ///TODO initialization
      user.userCoupling = [];
      user.userCoupling.add(UserCoupling(
          questionId: widget.questions.id, answer: json.encode(result)));
    }
    user.userCoupling = ([
      UserCoupling(
          questionId: widget.questions.id,
          answer: json.encode(result),
          qType: 'ranking')
    ]);
    print("after reorder : ${result.toString()}");
    print(
        "after reorder : ${user.userCoupling[user.userCoupling.length - 1].answer is String}");

    ///TODO udayipp code

    ///adding answers
    // Questions _questions = Questions.fromMap(GlobalData.couplingQuestion);
    // _questions.response[widget.index].userAnswer=UserAnswer(answer: '');

    setState(() {
      RestAPI().post('${APis.register}appstepsixteen', params: {
        "question_id": widget.questions.id,
        "answer": result.toString().split(" ").join("")
      }).then((value) {
        RestAPI().get(APis.getCouplingQuestions).then((value) {
          setState(() {
            GlobalData.couplingQuestion = value;
            print("kop");
            print(GlobalData.couplingQuestion);
          });
        });
      }, onError: (e) {
        GlobalWidgets().showToast(msg: CoupledStrings.errorMsg);
      });
    });
  }

  void handleReorder(int oldIndex, int index) {
    if (index > oldIndex) {
      // removing the item at oldIndex will shorten the list by 1.
      index -= 1;
    }
//		test.insert(index, test.removeAt(oldIndex));
    answerData.insert(index, answerData.removeAt(oldIndex));

    addValue();
  }

  @override
  void didChangeDependencies() {
    List defaultList = [];
    var a =
        Questions.fromMap(GlobalData.couplingQuestion as Map<String, dynamic>)
                .response![widget.index]
                .userAnswer!
                .answer ??
            '[]';
    print('arrange list');
    print(a);

    Questions.fromMap(GlobalData.couplingQuestion as Map<String, dynamic>)
        .response![widget.index]
        .answers!
        .forEach((element) {
      defaultList.add(element.id);
    });
    print('defaultList------');
    print(defaultList);
    answerData.clear();
    user = GlobalData.myProfile;
    UserCoupling userCoupling = user.userCoupling.singleWhere(
        (test) => test.questionId == widget.questions.id,
        orElse: () => UserCoupling());

    if (a == '[]') {
      defaultList.forEach((item) {
        answerData.add(
            widget.questions.answers.singleWhere((test) => test.id == item));
      });
      resetItems.addAll(answerData);
      print("Answers1 : $answerData");
    } else {
      (json.decode(Questions.fromMap(
                  GlobalData.couplingQuestion as Map<String, dynamic>)
              .response![widget.index]
              .userAnswer!
              .answer))
          .forEach((item) {
        answerData.add(
            widget.questions.answers.singleWhere((test) => test.id == item));
      });
      resetItems.addAll(answerData);
      print("Answers2 : $answerData");
    }

    userCoupling.qType = 'ranking';
    user.userCoupling = ([userCoupling]);
    // } else {
    //   // user.userCoupling = null;
    //   // answerData.addAll(widget.questions.answers);
    // }

    addValue();
    super.didChangeDependencies();
  }

  @override
  void initState() {
/*List initAnswers=[];
    widget.questions.answers.forEach((element) {
      initAnswers.add(element.id);
    });

    ///TODO udayipp code
    RestAPI().post('${APis.register}appstepsixteen', params: {
      "question_id": widget.questions.id,
      "answer": initAnswers.toString()
    }).then((value) async {
      GlobalData.couplingQuestion =
      await RestAPI().get(APis.getCouplingQuestions);
    }, onError: (e) {
      GlobalWidgets().showToast(msg: CoupledStrings.errorMsg);
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextView(
            widget.questions.question,
            size: 18.0,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textScaleFactor: .8,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: ReorderableListView(
                scrollController: ScrollController(),
                children: dummy(answerData),
                onReorder: (int oldIndex, int index) {
                  print("Reordering :: $oldIndex   $index");
                  setState(() {
                    handleReorder(oldIndex, index);
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextView(
                    "Longpress on a item to drag and arrange according to your preference.",
                    size: 13.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textScaleFactor: .8,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      answerData.clear();
                      answerData.addAll(resetItems);
                      print("resetItems : ${resetItems.toString()}");
                      addValue();
                      dragWidget.clear();
//                      dummy(widget.questions.answers);
                    });
                  },
                  child: TextView(
                    "Rearrange List",
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textScaleFactor: .8,
                    textAlign: TextAlign.center,
                    size: 12,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
