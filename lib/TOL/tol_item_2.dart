import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/TOL/Carousel/carousel_pro.dart';
import 'package:coupled/TOL/tol_checkout.dart';
import 'package:coupled/TOL/tol_helpers.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/tol_list_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

class TolItem extends StatefulWidget {
  @override
  _TolItemState createState() => _TolItemState();
}

class _TolItemState extends State<TolItem> {
  TolProductDatum item = TolProductDatum();

  @override
  void initState() {
    item = GlobalData.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      backgroundColor: CoupledTheme().backgroundColor,
      body: Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    getCarousal(context, item),
                    SizedBox(
                      height: 6,
                    ),
                    TextView(
                      '${item.name ?? ''}',
                      color: CoupledTheme().primaryBlue,
                      size: 22,
                      maxLines: 1,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.left,
                      textScaleFactor: .8,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextView(
                      GlobalData.selectedItem.productCode ?? '',
                      size: 16,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    QuantityButton(),
                    SizedBox(
                      height: 15,
                    ),
                    TextView(
                      '${CoupledStrings.INR} ${item.price.toString()}',
                      color: CoupledTheme().primaryPink,
                      size: 24,
                      maxLines: 1,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.left,
                      textScaleFactor: .8,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getDescription(
                        title: 'Product Details',
                        description: item.description),
                    getDescription(
                        title: 'Key Features',
                        isList: true,
                        features: List<String>.generate(
                            item.productFeatures!.length,
                            (index) => item.productFeatures![index].content)),
                    getDescription(
                        title: 'Delivery Info', description: item.deliveryInfo),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                width: MediaQuery.of(context).size.width.toDouble(),
                height: 45.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TolCheckOut(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(0),
                gradient: LinearGradient(colors: [
                  CoupledTheme().primaryPinkDark,
                  CoupledTheme().primaryPink
                ]),
                child: TextView(
                  "Buy",
                  size: 16,
                  maxLines: 1,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  color: Colors.white,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///TOL ITEM
getCarousal(BuildContext context, TolProductDatum item) {
  return SizedBox(
    height: 200.0,
    child: Carousel(
      boxFit: BoxFit.cover,
      autoplay: true,
      autoplayDuration: Duration(milliseconds: 5000),
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
      dotSize: 6.0,
      dotIncreasedColor: Color(0xFFFF335C),
      dotBgColor: Colors.transparent,
      dotPosition: DotPosition.bottomCenter,
      dotVerticalPadding: 10.0,
      showIndicator: true,
      borderRadius: true,
      indicatorBgPadding: 7.0,
      images: List.generate(
          item.images!.length,
          (index) => FadeInImage.assetNetwork(
                width: MediaQuery.of(context).size.width,
                height: (72 * MediaQuery.of(context).size.height) / 100,
                fit: BoxFit.contain,
                placeholder: 'assets/no_image.jpg',
                image: APis().imageApi(item.images![index].imageName,
                    imageFolder: ImageFolder.TOL),
              )),
      onImageChange: (int, int1) {},
      onImageTap: (int) {},
      overlayShadowColors: Colors.white,
      radius: Radius.circular(10),
    ),
  );
}
