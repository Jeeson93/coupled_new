import 'dart:async';
import 'package:coupled/Utils/carosal_pro.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroSlider extends StatelessWidget {
  static String route = 'IntroSlider';

  @override
  Widget build(BuildContext context) {
    return IntroSliderScreen();
  }
}

class IntroSliderScreen extends StatefulWidget {
  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSliderScreen>
    with TickerProviderStateMixin {
  late PageController _controller;

  List<IntroItem> introlist = [
    IntroItem(
      "About Coupled",
      'assets/intro_love.jpg',
      "Coupled.in takes a courtship route in arranging matrimony, have promising ingredients "
          "to stumble upon love and confidence to get married with right partner, at right time.  \n\n"
          "Coupled is simple, progressive and contemporary. It’s an informal place to "
          "meet serious partners,who are matured to the idea of marriage, successful in their fields and on family front,"
          " and ready to settle down.\n\n"
          "We believe in keeping the discovery of a life partner filled with emotions & expressions,tuning two minds together,"
          " eventually bringing two souls to find love and to carry forward a journey "
          "of having met a soul mate not just a partner. \n\n"
          "Our platform understands you as a person, maps down"
          " the traits of your personality, evaluates alongside all the profiles "
          "and produce the most suitable matches and predictions based on the Coupling Score. ",
      false,
      "Coupling Score",
      'assets/intro_flower.jpg',
      "Discover similarities and differences between your prospective partner on physical and psychological aspects of personality.\n\n"
          "Finding the right partner is the biggest test of life for the men and women alike.  "
          "Coupling Score makes it easier to bring two potential partners together through our carefully researched and selected set of Q & A’s,"
          "which give compelling insights into a prospective partner’s personality."
          "It helps decode your compatibility and explore your expectations from a partner, "
          " empowers you to make a confident and informed decision in choosing a life partner.\n\n"
          "We establish testimony of having connection, draw predictions to support it"
          "and play the role of a friendly matchmaker throughout the journey of finding your soul mate at Coupled.",
      false,
      Color(0xffffcee1),
      Color(0xfffdb4c8),
      Color(0xfff64a66),
    ),
    IntroItem(
      "Token of Love",
      'assets/intro_girl.jpg',
      "Surprise the special one with a gift and take the proposal to next level.\n\n"
          "Most times love needs an expression. At coupled, there is no stopping "
          "in expressing your emotions beyond words, surprise and impress your partner with a bouquet of roses or a chocolate."
          "To send a gift to your partner this way, earn three roses during your conversations and unlock the magic of love.",
      false,
      "Flexi Membership Plans Pay as per use",
      'assets/intro_cake.jpg',
      "Our one-time, flexi-membership plans make your courtship journey lighter on your pocket.\n\n"
          "Yes, you got it right no membership renewal required! "
          "You have the freedom to choose the most suitable member plan and top up your account in the form of contact & chat credits afterwards,"
          "as and when required.\n\n"
          "● Know your partner better with detailed Coupling Score and Predictions.\n\n"
          "● Have hearty conversations and unlock the ‘Token of Love’\n\n"
          "● Send or Respond to an interest with personal message\n\n"
          "● View the contact details of a partner\n\n"
          "● Recommend or Share a profile\n\n"
          "● Get featured in the list of top profiles\n\n",
      false,
      Color(0xffc9e2f6),
      Color(0xffb1cbe9),
      Color(0xff5270b7),
    ),
    IntroItem(
      "Recommend and earn Credits",
      'assets/intro_chocolate.jpg',
      "Help us spread the love by sharing a genuine recommendation for a profile.\n\n"
          "You can play cupid or be a match-maker for other members at Coupled. "
          "Take out few seconds to recommend a profile, which you find interesting, impressive "
          "and genuine on any of the listed characteristics. And we would return the "
          "favor in form of additional contact & chat credits in your account.\n\n",
      false,
      "Serious and Sensible",
      'assets/intro_car.jpg',
      "Coupled is a thinking, intelligent and engaging platform.\n\n"
          "Life is anything but easy & simple, so we make sure that that we give answers"
          " to the most complex of puzzles related to arrange marriages."
          " We make sense from suggesting profiles to match predictions to interact with the real "
          "partners (Not their family and friends) to expressing afresh with customized emojis stickers, "
          "aiding with insights in making conversations click.\n\n"
          "Marriage is an affair of a life-time and we own it up on your behalf!",
      false,
      Color(0xffffcee1),
      Color(0xfffdb4c8),
      Color(0xfff64a66),
    ),
  ];
  Curve animationCurve = Curves.easeInOut;
  Duration duration = Duration(milliseconds: 2000);
  double maxWidth = 220.0;
  Duration _durationPosition = Duration(milliseconds: 350);
  Duration _durationCrossFade = Duration(milliseconds: 200);

  List<Widget> dummy(BuildContext context) {
    List<Widget> introSliderContent = [];
    for (var i = 0; i < introlist.length; i++) {
      introSliderContent.add(
        Container(
          color: introlist[i]._bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(
                                introlist[i].descExpanded ? 0.2 : 1.0),
                            BlendMode.dstATop),
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.topCenter,
                        image: AssetImage(introlist[i]._imgPath),
                      )),
                    ),
                    AnimatedPositioned(
                      duration: _durationPosition,
                      curve: Curves.easeInOut,
                      bottom: 0.0,
                      right: 10.0,
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: introlist[i].descExpanded
                          ? MediaQuery.of(context).size.height / 2.5
                          : MediaQuery.of(context).size.height / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextView(
                            introlist[i]._title,
                            textAlign: TextAlign.end,
                            color: introlist[i]._titleColor,
                            size: 28.0,
                            fontWeight: FontWeight.bold,
                            lineSpacing: 0,
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                            decoration: TextDecoration.none,
                            textScaleFactor: .7,
                          ),
                          Flexible(
                            child: AnimatedCrossFade(
                              duration: _durationCrossFade,
                              crossFadeState: introlist[i].descExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: TextView(
                                introlist[i]._desc,
                                textAlign: TextAlign.justify,
                                maxLines: 10,
                                color: introlist[i]._titleColor,
                                fontWeight: FontWeight.bold,
                                lineSpacing: 0,
                                overflow: TextOverflow.clip,
                                decoration: TextDecoration.none,
                                textScaleFactor: .8,
                                size: 12,
                              ),
                              secondChild: SingleChildScrollView(
                                child: TextView(
                                  introlist[i]._desc,
                                  textAlign: TextAlign.justify,
                                  color: introlist[i]._titleColor,
                                  fontWeight: FontWeight.bold,
                                  lineSpacing: 0,
                                  maxLines: 60,
                                  overflow: TextOverflow.visible,
                                  decoration: TextDecoration.none,
                                  textScaleFactor: .8,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                introlist[i].descExpanded =
                                    !introlist[i].descExpanded;

                                introlist[i].descExpanded2 = false;
                                autoPlay.add(!introlist[i].descExpanded &&
                                    !introlist[i].descExpanded2);
//                                pageAutoScroll(introlist[i].descExpanded, introlist[i].descExpanded2);
                              });
                            },
                            child: Container(
                              height: 20.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/more.png',
                                      ),
                                      colorFilter: ColorFilter.mode(
                                          introlist[i]._titleColor,
                                          BlendMode.srcIn)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: introlist[i]._moreColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(
                                introlist[i].descExpanded2 ? 0.2 : 1.0),
                            BlendMode.dstATop),
                        alignment: FractionalOffset.topCenter,
                        image: AssetImage(introlist[i]._imgPath2),
                      )),
                    ),
                    AnimatedPositioned(
                      duration: _durationPosition,
                      top: 20.0,
                      left: 10.0,
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: introlist[i].descExpanded2
                          ? MediaQuery.of(context).size.height / 2.5
                          : MediaQuery.of(context).size.height / 5,
                      curve: Curves.easeInOut,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TextView(
                            introlist[i]._title2,
                            color: introlist[i]._titleColor,
                            size: 28.0.toDouble(),
                            fontWeight: FontWeight.bold,
                            lineSpacing: 0.0,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            decoration: TextDecoration.none,
                            textScaleFactor: .7.toDouble(),
                          ),
                          Flexible(
                            child: AnimatedCrossFade(
                              duration: _durationCrossFade,
                              crossFadeState: introlist[i].descExpanded2
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: TextView(
                                introlist[i]._desc2,
                                textAlign: TextAlign.justify,
                                color: introlist[i]._titleColor,
                                fontWeight: FontWeight.bold,
                                maxLines: 10,
                                overflow: TextOverflow.fade,
                                decoration: TextDecoration.none,
                                textScaleFactor: .8,
                                lineSpacing: 0,
                                size: 12.0,
                              ),
                              secondChild: SingleChildScrollView(
                                child: Container(
                                  child: TextView(
                                    introlist[i]._desc2,
                                    textAlign: TextAlign.justify,
                                    color: introlist[i]._titleColor,
                                    fontWeight: FontWeight.bold,
                                    lineSpacing: 0,
                                    maxLines: 60,
                                    overflow: TextOverflow.visible,
                                    decoration: TextDecoration.none,
                                    textScaleFactor: .8,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                introlist[i].descExpanded2 =
                                    !introlist[i].descExpanded2;

                                introlist[i].descExpanded = false;
                                autoPlay.add(!introlist[i].descExpanded &&
                                    !introlist[i].descExpanded2);
//                                pageAutoScroll(introlist[i].descExpanded, introlist[i].descExpanded2);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              height: 20.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: const AssetImage(
                                        'assets/more.png',
                                      ),
                                      colorFilter: ColorFilter.mode(
                                          introlist[i]._titleColor,
                                          BlendMode.srcIn)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  color: introlist[i]._moreColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return introSliderContent;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  int _start = 5;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            }));
  }

/*
  void pageAutoScroll([isBanner1Expanded, isBanner2Expanded]) {

    const oneSec = const Duration(seconds: 6);
    if(isBanner1Expanded!=null && isBanner2Expanded != null) {
	    if (!isBanner1Expanded && !isBanner2Expanded) {
		    _timer = Timer.periodic(
			    oneSec,
					    (Timer timer) =>
					    setState(
								    () {
							    _controller.nextPage(
								    duration: duration,
								    curve: animationCurve,
							    );
						    },
					    ),
		    );
	    } else
		    _timer.cancel();
    }else{
	    _timer = Timer.periodic(
		    oneSec,
				    (Timer timer) =>
				    setState(
							    () {
						    _controller.nextPage(
							    duration: duration,
							    curve: animationCurve,
						    );
					    },
				    ),
	    );
    }
  }*/

/*  void _onScroll() {
    if (_controller.page.toInt() == _controller.page) {
      setState(() {
        currentPage = _controller.page.toInt();
      });
    }
  }*/
  @override
  void initState() {
    startTimer();
//    pageAutoScroll(false, false);
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
//    pageAutoScroll(true, true);
    autoPlay.close();
    super.dispose();
  }

  StreamController<bool> autoPlay = StreamController();
  var currentPage = 0;
  Color scaffoldBackground = Color(0xfff64a66);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: scaffoldBackground,
      ),
      child: Scaffold(
        backgroundColor: scaffoldBackground,
        body: SafeArea(
          minimum: EdgeInsets.only(top: -15.0),
          bottom: false,
          child: Builder(
            builder: (context) => Stack(
              children: <Widget>[
                Carousel(
                  carouselController: autoPlay,
                  widget: dummy(context),
                  dotsDecorator: DotsDecorator(
                      size: const Size.fromRadius(3.0),
                      spacing: EdgeInsets.all(1.0),
                      color: currentPage == 1
                          ? CoupledTheme().primaryBlue
                          : CoupledTheme().primaryPink,
                      activeColor: currentPage == 1
                          ? CoupledTheme().linkedInColor
                          : CoupledTheme().primaryPink,
                      activeSize: const Size.fromRadius(5.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                  animationDuration: duration,
                  animationCurve: animationCurve,
                  moveIndicatorFromBottom: 10.0,
                  controller: _controller,
                  onPageChaged: (index) {
                    setState(() {
                      currentPage = index;
                      scaffoldBackground = introlist[currentPage]._titleColor;
                      introlist[currentPage].descExpanded = false;
                      introlist[currentPage].descExpanded2 = false;
                      /*    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
					          statusBarColor: scaffoldBackground, //or set color with: Color(0xFF0000FF)
				          ));*/
                    });
                  },
                ),
                /*   PageView.builder(
                  itemBuilder: (context, index) {
                    return dummy(context)[index % 3];
                  },
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index % 3;
                      scaffoldBackground = introlist[currentPage]._titleColor;
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
                        statusBarColor: scaffoldBackground, //or set color with: Color(0xFF0000FF)
                      ));
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment(0, 1),
                    child: DotsIndicator(
                      dotsCount: introlist.length,
                      position: currentPage.roundToDouble(),
                      decorator: DotsDecorator(
		                  size: const Size.fromRadius(3.0),
		                  spacing: EdgeInsets.all(1.0),
		                  color: currentPage == 1 ? CoupledTheme().primaryBlue : CoupledTheme().primaryPink,
		                  activeColor:
		                  currentPage == 1 ? CoupledTheme().linkedInColor : CoupledTheme().primaryPink,
		                  activeSize: const Size.fromRadius(5.0),
		                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                    ),
                  ),
                ),*/
                Positioned(
                  top: 10.0,
                  right: 0.0,
                  height: 25.0,
                  child: MaterialButton(
                      onPressed: () async {
                        if (_start == 0) {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          await pref.setInt("redirectTo", 1);
                          Navigator.of(context)
                              .pushReplacementNamed('/startMain');
                        }
                      },
//                  color: Colors.black38,
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(30.0)),
                      child: _start == 0
                          ? TextView(
                              "Skip",
                              color: scaffoldBackground,
                              fontWeight: FontWeight.bold,
                              lineSpacing: 0,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              decoration: TextDecoration.none,
                              textScaleFactor: 1,
                              size: 12,
                            )
                          : TextView(
                              "Skip $_start",
                              color: scaffoldBackground,
                              fontWeight: FontWeight.bold,
                              lineSpacing: 1,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              decoration: TextDecoration.none,
                              textScaleFactor: 1,
                              size: 12,
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntroItem {
  String _title, _imgPath, _desc, _title2, _imgPath2, _desc2;
  Color _titleColor, _moreColor, _bgColor;
  bool descExpanded, descExpanded2;

  IntroItem(
    this._title,
    this._imgPath,
    this._desc,
    this.descExpanded,
    this._title2,
    this._imgPath2,
    this._desc2,
    this.descExpanded2,
    this._bgColor,
    this._moreColor,
    this._titleColor,
  );

  @override
  String toString() {
    return 'IntroItem{_title: $_title, _imgPath: $_imgPath, _desc: $_desc, _title2: $_title2, _imgPath2: $_imgPath2, _desc2: $_desc2, _titleColor: $_titleColor, _moreColor: $_moreColor, _bgColor: $_bgColor}';
  }
}
