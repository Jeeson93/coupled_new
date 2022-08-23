import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:coupled/models/questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouplingQuestion extends StatefulWidget {
  final Questions questions;

  CouplingQuestion({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  _CouplingQuestionState createState() => _CouplingQuestionState();
}

class _CouplingQuestionState extends State<CouplingQuestion>
    with AutomaticKeepAliveClientMixin {
  bool _physicalIsChecked = false,
      _psychologicalIsChecked = false,
      canSelect = false;
  int _physicalSelectedIndex = -1, _psychologicalSelectedIndex = -1;
  dynamic _matchMakerModel;

  CounterBloc _counterBloc = CounterBloc();

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _counterBloc = MatchMakerProvider.of(context)!.counterBloc;
    _matchMakerModel = MatchMakerProvider.of(context)!.matchMakerModel;
    if (_matchMakerModel.question_1 > 0 && _matchMakerModel.answer_1 > 0) {
      _physicalIsChecked = canSelect = true;
      // _physicalIsChecked = canSelect = MatchMakerProvider.of(context).chkMaxFilterReached(true);
    } else if (_matchMakerModel.question_2 > 0 &&
        _matchMakerModel.answer_2 > 0) {
      _psychologicalIsChecked = canSelect = true;
      // _psychologicalIsChecked = canSelect = MatchMakerProvider.of(context).chkMaxFilterReached(true);
    }
    print("CANSELECT $canSelect");
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener(
      bloc: _counterBloc,
      listener: (context, state) {
        if (state is CounterClearAll) {
          setState(() {
            _physicalSelectedIndex = _psychologicalSelectedIndex = -1;
            _psychologicalIsChecked = _physicalIsChecked = false;
            _matchMakerModel.question_1 = 2;
            _matchMakerModel.question_2 = 11;
            _matchMakerModel.answer_1 = 0;
            _matchMakerModel.answer_2 = 0;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
        child: CustomScrollView(
          slivers: [
            widget.questions == null
                ? SliverList(
                    delegate: SliverChildListDelegate([]),
                  )
                : SliverList(
                    delegate: SliverChildListDelegate([
                    physicalPsychological(true),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "--- OR ---",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
                    physicalPsychological(false),
                  ]))
          ],
        ),
      ),
    );
  }

  Widget physicalPsychological(isPhysicalQuestion) {
    QResponse _qResponse;
    List<QResponse> _physical = [], _psychological = [];
    print('=====================${widget.questions.response}');
    _physical.addAll(
        widget.questions.response!.where((i) => i.couplingType == 'physical'));
    _psychological.addAll(widget.questions.response!
        .where((i) => i.couplingType == 'psychological'));
    _physical.sort((QResponse a, QResponse b) =>
        a.questionOrder.compareTo(b.questionOrder));
    _psychological.sort((QResponse a, QResponse b) =>
        a.questionOrder.compareTo(b.questionOrder));
    if (isPhysicalQuestion) {
      _qResponse = _physical.singleWhere((response) => response.id == 2);
    } else {
      _qResponse = _psychological.singleWhere((response) => response.id == 11);
    }

    for (var i = 0; i < _qResponse.answers!.length; i++) {
      print("${_qResponse.answers![i].id} ${_matchMakerModel.answer_1}");
      if (_physicalIsChecked) {
        if (_qResponse.answers![i].id == _matchMakerModel.answer_1)
          _physicalSelectedIndex = i;
      } else {
        if (_qResponse.answers![i].id == _matchMakerModel.answer_2)
          _psychologicalSelectedIndex = i;
      }
    }
    print(
        "SELECTED INDEX : $_physicalSelectedIndex $_psychologicalSelectedIndex");
    print("QRESPONSE : $_qResponse");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomCheckBox(
          enabled:
              isPhysicalQuestion ? _physicalIsChecked : _psychologicalIsChecked,
          value:
              isPhysicalQuestion ? _physicalIsChecked : _psychologicalIsChecked,
          text: _qResponse.question,
          textSize: 16.0,
          checkBoxSize: 30.0,
          onChanged: (val) {
            if (!val!) {
              // canSelect = MatchMakerProvider.of(context).chkMaxFilterReached(false);
              canSelect = false;
              _physicalIsChecked = false;
              _psychologicalIsChecked = false;
              _matchMakerModel.question_1 = 0;
              _matchMakerModel.answer_1 = 0;
              _matchMakerModel.question_2 = 0;
              _matchMakerModel.answer_2 = 0;
              _psychologicalSelectedIndex = -1;

              _physicalSelectedIndex = -1;
            }
            setState(() {});
            print(_matchMakerModel.matchMakerParams());
          },
          secondary: SizedBox(),
        ),
        SizedBox(
          height: 32.0,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _qResponse.answers!.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                SelectionBox(
                  height: 50.0,
                  child: Center(
                      child: TextView(_qResponse.answers![index].answerOption,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .9,size: 12,)),
                  radius: 5.0,
                  onTap: () {
                    if (!canSelect) {
                      canSelect = true;
                    }
                    if (canSelect) {
                      print(_qResponse.answers![index].answerOption);
                      _physicalIsChecked = isPhysicalQuestion;
                      _psychologicalIsChecked = !isPhysicalQuestion;

                      onSelected(isPhysicalQuestion, index);

                      _matchMakerModel.question_1 =
                          isPhysicalQuestion ? _qResponse.id : null;
                      _matchMakerModel.answer_1 = isPhysicalQuestion
                          ? _qResponse.answers![index].id
                          : null;
                      _matchMakerModel.question_2 =
                          !isPhysicalQuestion ? _qResponse.id : null;
                      _matchMakerModel.answer_2 = !isPhysicalQuestion
                          ? _qResponse.answers![index].id
                          : null;

                      print(_matchMakerModel.matchMakerParams());
                    }
                  },
                  innerColor: isPhysicalQuestion
                      ? _physicalSelectedIndex == index
                          ? CoupledTheme().primaryPinkDark
                          : null
                      : _psychologicalSelectedIndex == index
                          ? CoupledTheme().primaryPinkDark
                          : null,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  onSelected(bool isPhysicalQuestion, int index) {
    if (isPhysicalQuestion) {
      _physicalSelectedIndex = index;
      _psychologicalSelectedIndex = -1;
    } else {
      _psychologicalSelectedIndex = index;
      _physicalSelectedIndex = -1;
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
