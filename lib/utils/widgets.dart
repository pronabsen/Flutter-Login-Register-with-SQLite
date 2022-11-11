import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../screens/home_screen.dart';
import 'Colors.dart';

Widget text({
  required String txt,
  double size = 12,
  final Color? color = white,
  final FontWeight? fontWeight,
  final TextAlign? textAlign,
  final Color? backgroundColor,
}) {
  return Text(
    txt,
    textAlign: textAlign,
    style: TextStyle(backgroundColor: backgroundColor, color: color, fontSize: size, fontWeight: fontWeight),
  );
}

Widget customButton({
  final GestureTapCallback? onTap,
  String txt = "",
  double? wid,
  double? high = 40,
  final Color? color = black,
  final double? elevation = 10,
  final BoxBorder? border,
  final Color? txtcolor = white,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      child: Container(
        height: high,
        width: wid,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: border, color: color, borderRadius: BorderRadius.circular(45)),
        child: Text(txt, style: TextStyle(color: txtcolor)),
      ),
    ),
  );
}

Widget customButton_1({
  final GestureTapCallback? onTap,
  String txt = "",
  final Color? color = primaryBlackColor,
  final double? elevation = 10,
  final BoxBorder? border,
  final Color? txtcolor = primaryWhiteColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: border, color: color, borderRadius: BorderRadius.circular(15)),
        child: Text(txt, style: TextStyle(color: txtcolor)),
      ),
    ),
  );
}

Future customDialoge(
  BuildContext context, {
  final GestureTapCallback? onTap,
  final List<Widget>? actions,
  // Flash? i,
  var arguments,
}) {
  //var flashObserver = i;
  return showDialog(
    context: context,
    builder: (context) {
      Timer.periodic(Duration(milliseconds: 500), (timer) {
        //appStore.i += 1;
        if (timer.tick == 500) {
          timer.cancel();
        }
      });
      Timer(
        Duration(seconds: 1),
        () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
      final high = MediaQuery.of(context).size.width;
      return AlertDialog(
        scrollable: true,
        actions: actions,
        backgroundColor: context.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        content: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            width: high / 6 * 3,
            child: FittedBox(
              child: Column(
                children: [
                  16.height,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(42),
                        decoration: boxDecorationWithRoundedCorners(
                          boxShape: BoxShape.circle,
                          backgroundColor: appStore.isDarkModeOn ? cardDarkColor : black,
                        ),
                      ),
                      Icon(Icons.person, size: 50, color: appStore.isDarkModeOn ? white : white)
                    ],
                  ),
                  24.height,
                  Text('Congratulations', style: boldTextStyle(size: 18)),
                  SizedBox(height: 15),
                  Text(
                    'Your account is ready to use. You will\nbe redirected to the home page in a\nfew seconds',
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle(),
                  ),
                  SizedBox(height: 15),
                  Observer(
                    builder: (context) => Transform.rotate(
                      angle: 0.5,
                      child: Image(image: AssetImage('assets/gifs/app_loader.gif'), color: context.iconColor, height: high / 24 * 3, width: high / 24 * 3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

PreferredSizeWidget customAppBarWidget(BuildContext context, {String? titleText, Widget? actionWidget, Widget? actionWidget2}) {
  return AppBar(
    backgroundColor: context.scaffoldBackgroundColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: context.iconColor),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [actionWidget ?? SizedBox(), actionWidget2 ?? SizedBox()],
    title: Text(titleText ?? "", style: boldTextStyle(size: 18)),
    elevation: 0.0,
  );
}

InputDecoration inputDecoration(
  BuildContext context, {
  IconData? prefixIcon,
  Widget? suffixIcon,
  String? labelText,
  double? borderRadius,
  String? hintText,
}) {
  return InputDecoration(
    counterText: "",
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    hintText: hintText.validate(),
    hintStyle: secondaryTextStyle(),
    isDense: true,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 16, color: appStore.isDarkModeOn ? white : gray) : null,
    suffixIcon: suffixIcon.validate(),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    filled: true,
    fillColor: editTextBgColor,
  );
}

Decoration commonDecoration({double? cornorRadius}) {
  return boxDecorationWithRoundedCorners(
    backgroundColor: white,
    borderRadius: BorderRadius.all(Radius.circular(cornorRadius ?? 8.0)),
    border: Border.all(color: appStore.isDarkModeOn ? white : gray.withOpacity(0.1)),
  );
}
