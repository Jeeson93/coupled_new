import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/Modals/dialogs.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/questions.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/controller/page_controller.dart';
import 'package:coupled/registration_new/reg_steps/coupling_questions/CouplingQuestion.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

class CouplingScoreQuestions extends StatefulWidget {
  static String route = 'CouplingScoreQuestions';

  @override
  _CouplingScoreQuestionsState createState() => _CouplingScoreQuestionsState();
}

class _CouplingScoreQuestionsState extends State<CouplingScoreQuestions> {
  PageController _pageController = PageController();
  Questions _questions = Questions(response: []);
  Widget body = Container();

  @override
  void initState() {
    RestAPI().get(APis.getCouplingQuestions).then((value) {
      GlobalData.couplingQuestion = value;
      setState(() {
        body = PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: arrangeWidgetTemplate());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
      child: Scaffold(
          backgroundColor: CoupledTheme().backgroundColor,
          appBar: getRegAppBar(context,
              progress: 0.8, title: 'Coupling Questions', step: 11),
          body: Stack(
            children: [
              Container(
                height: double.infinity,
              ),
              body,
              Positioned(
                bottom: 5,
                left: 15,
                right: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///previous button
                    CustomButton(
                      // enabled: !isLoading,
                      child: Icon(
                        Icons.chevron_left,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        previousPage();
                        // Navigator.pushNamed(context, registrationPages[16 - 2]);
                        print('_pageController.page---');
                        print(_pageController.page);
                        if (_pageController.page == 0.0) {
                          Navigator.pushNamed(
                              context, registrationPages[16 - 2]);
                        }
                      },
                      height: 40.0,
                      width: 40.0,
                      borderRadius: BorderRadius.circular(100.0),
                      gradient: LinearGradient(colors: [
                        CoupledTheme().primaryBlue,
                        CoupledTheme().primaryBlue
                      ]),
                    ),

                    ///next button
                    CustomButton(
                      // enabled:!(_pageController.page == 15.0 && GlobalData.myProfile?.usersBasicDetails?.registrationStatus==1),
                      child: Icon(
                        Icons.chevron_right,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          print('object--------------');
                          if (Questions.fromMap(GlobalData.couplingQuestion
                                      as Map<String, dynamic>)
                                  .response?[_pageController.page!.toInt()]
                                  .subQuestion ==
                              null) {
                            print(Questions.fromMap(GlobalData.couplingQuestion
                                    as Map<String, dynamic>)
                                .response![_pageController.page!.toInt()]
                                .userAnswer!
                                .answer);
                            if (Questions.fromMap(GlobalData.couplingQuestion
                                        as Map<String, dynamic>)
                                    .response![_pageController.page!.toInt()]
                                    .userAnswer
                                    ?.answer !=
                                null) {
                              nextPage();
                            } else {
                              print("jomo");
                              setState(() {
                                GlobalWidgets()
                                    .showToast(msg: 'Please choose the answer');
                              });
                            }
                          } else {
                            if ((Questions.fromMap(GlobalData.couplingQuestion
                                            as Map<String, dynamic>)
                                        .response![
                                            _pageController.page!.toInt()]
                                        .subQuestion !=
                                    null) &&
                                (Questions.fromMap(GlobalData.couplingQuestion
                                            as Map<String, dynamic>)
                                        .response![
                                            _pageController.page!.toInt()]
                                        .userAnswer !=
                                    null)) {
                              nextPage();
                            } else {
                              print("raghu");
                              GlobalWidgets()
                                  .showToast(msg: 'Please choose the answer');
                            }
                          }

                          print('_pageController.page---');
                          print(_pageController.page);
                          if (_pageController.page == 15.0 &&
                              GlobalData.myProfile.usersBasicDetails!
                                      .registrationStatus !=
                                  1) {
                            Navigator.pushNamed(context, registrationPages[17]);
                          }
                        });
                      },
                      height: 40.0,
                      width: 40.0,
                      borderRadius: BorderRadius.circular(100.0),
                      gradient: LinearGradient(colors: [
                        CoupledTheme().primaryBlue,
                        CoupledTheme().primaryBlue
                      ]),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  void nextPage() {
    _pageController.animateToPage(_pageController.page!.toInt() + 1,
        duration: Duration(milliseconds: 600), curve: Curves.easeIn);
  }

  void previousPage() {
    _pageController.animateToPage(_pageController.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  arrangeWidgetTemplate() {
    _questions =
        Questions.fromMap(GlobalData.couplingQuestion as Map<String, dynamic>);

    print('GlobalData.couplingQuestion-----');
    print(_questions.response![0].userAnswer);

    List<QResponse> _physical = [], _psychological = [];
    _physical.addAll(
        _questions.response!.where((i) => i.couplingType == 'physical'));
    _psychological.addAll(
        _questions.response!.where((i) => i.couplingType == 'psychological'));
    _physical.sort((QResponse a, QResponse b) =>
        a.questionOrder.compareTo(b.questionOrder));
    _psychological.sort((QResponse a, QResponse b) =>
        a.questionOrder.compareTo(b.questionOrder));
    // physicalLength = _physical.length;
    //  psychologicalLength = _psychological.length;
    _questions.response = [];
    _questions.response?.addAll(_physical);
    _questions.response?.addAll(_psychological);

    List<Widget> qWidgets = [];

    //_widgets.addAll(sections);
    _questions.response!.asMap().forEach((index, response) {
      switch (response.type) {
        case 'co_work':
        case 'equals':
        case 'avg':
        case 'equals_pref':
          qWidgets.add(SingleQuesModal(
            key: ObjectKey(response),
            questions: response,
            index: index,
            /*  selectedValue: (selectedValue) {
                print("selectedValue Single:: $selectedValue");
                _couplingQProfileResponse.addAll(selectedValue);
              },*/
          ));
          // qType.add('single');
          break;
        case 'co_product':
        case 'product':
        case 'co_equals':
          qWidgets.add(NestedQuestion(
            //  bloc: _registerBloc,
            questions: response,
            index: index,
            /* selectedValue: (selectedValue) {
                print("selectedValue Nested:: $selectedValue");
                _couplingQProfileResponse = selectedValue;
              },*/
          ));
          // qType.add('multi');
          break;
        case 'co_ranking':
        case 'ranking':
          qWidgets.add(
            DragDropModal(
              questions: response,
              index: index,
              //  bloc: _registerBloc,
              /*   selectedValue: (selectedValue) {
                  print("selectedValue Ranking:: $selectedValue");
                  _couplingQProfileResponse = selectedValue;
                },*/
            ),
          );
          // qType.add('ranking');
          break;
      }
    });
    print('qWidgets-----');
    print(qWidgets.length);
    print(qWidgets);
    return qWidgets;
  }
}
