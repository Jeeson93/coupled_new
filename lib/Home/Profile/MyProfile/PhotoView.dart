import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/custom_progress_bar.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/profile.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatefulWidget {
  final List<Dp?> photos;
  final double pageIndex;

  PhotoView({required this.photos, required this.pageIndex});

  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  var _pagerPosition = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> profileImages = [];
  double screenWidth = 0.0;

  void onPageChanged(int value) {
    setState(() {
      _pagerPosition = value;
    });
  }

/*  gotoEditPage(GotoPage goto) async {
    var result = await Navigator.of(context).pushNamed('/personDetailPage',
        arguments: PersonalDetails(
          profileEdit: true,
          gotoPage: goto,
        ));
    print(result);
  }*/

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 300), () {
      print(widget.pageIndex);
      pageController.animateToPage(widget.pageIndex.round(),
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
    if (widget.photos != null && profileImages.length == 0) {
      widget.photos.forEach((photo) {
        print(APis().imageApi(
          photo?.photoName,
        ));

        photo?.dpStatus == 1
            ? profileImages.insert(
                0,
                Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 10 / 10,
                        child: Image(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                            APis().imageApi(
                              photo?.photoName,
                            ),
                          ),
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black38,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black87,
                                ],
                                stops: [
                                  0.15,
                                  0.50,
                                  0.25,
                                  0.75,
                                  1.0
                                ],
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter)),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 20),
                            child: TextView(
                              "Uploaded on : " +
                                  GlobalWidgets().getTime(photo?.createdAt),
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.visible,
                              size: 12,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 20, bottom: 10),
                                    child: TextView(
                                      (photo?.imageType?.value).toString(),
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 20, bottom: 20),
                                    child: TextView(
                                      (photo?.imageTaken?.value).toString(),
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              )
                            ]),
                      ),
                      Positioned(
                        left: 10,
                        top: 40,
                        child: CustomButton(
                          height: 25.0,
                          width: 35.0,
                          buttonType: ButtonType.FLAT,
                          gradient: LinearGradient(colors: <Color>[
                            Colors.transparent,
                            Colors.transparent,
                          ]),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ))
            : profileImages.add(Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 10 / 10,
                      child: Image(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          APis().imageApi(
                            photo?.photoName,
                          ),
                        ),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                              colors: [
                                Colors.black38,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black87,
                              ],
                              stops: [
                                0.15,
                                0.50,
                                0.25,
                                0.75,
                                1.0
                              ],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter)),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Padding(
                                padding: EdgeInsets.only(left: 20, bottom: 10),
                                child: TextView(
                                  "Uploaded on : " +
                                      GlobalWidgets().getTime(photo?.createdAt),
                                  decoration: TextDecoration.none,
                                  overflow: TextOverflow.visible,
                                  size: 12,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, bottom: 2),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 20, bottom: 2),
                                          child: TextView(
                                            (photo?.imageType?.value)
                                                .toString(),
                                            decoration: TextDecoration.none,
                                            overflow: TextOverflow.visible,
                                            size: 12,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ))),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 20, bottom: 10),
                                          child: TextView(
                                            (photo?.imageTaken?.value)
                                                .toString(),
                                            decoration: TextDecoration.none,
                                            overflow: TextOverflow.visible,
                                            size: 12,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ))),
                                ),
                              )
                            ]),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 40,
                      child: CustomButton(
                        height: 25.0,
                        width: 35.0,
                        buttonType: ButtonType.FLAT,
                        gradient: LinearGradient(colors: <Color>[
                          Colors.transparent,
                          Colors.transparent,
                        ]),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ));
      });
      print("profileImages :${widget.photos.length} ${profileImages.length}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView.builder(
                controller: pageController,
                onPageChanged: onPageChanged,
                itemCount: profileImages.length,
                itemBuilder: (context, position) {
                  return profileImages[position];
                }),
            Container(
              height: 6,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Container(
                      height: 6,
                      width: screenWidth / profileImages.length,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: CustomProgressBar(
                          value: _pagerPosition == index ? 1 : 0,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CoupledTheme().primaryBlue),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: profileImages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
