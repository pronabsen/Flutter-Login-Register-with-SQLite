
import 'package:flutter/material.dart';
import 'package:library_management/screens/login_screen.dart';
import 'package:library_management/screens/register_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/app_component.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  int currentPage = 0;
  List<WalkThroughModelClass> list = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    list.add(WalkThroughModelClass(title: 'Search Books\nWhat you want!', image: 'assets/images/search.png'));
    list.add(WalkThroughModelClass(title: 'Reserved any Books!', image: 'assets/images/reserve.png'));
    list.add(WalkThroughModelClass(title: 'Listen Books!', image: 'assets/images/audiobooks.png'));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          PageView(
            controller: pageController,
            children: list.map((e) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(e.image.validate()),
                  const SizedBox(height: 20),
                  Text(e.title.validate(), style: boldTextStyle(size: 28), textAlign: TextAlign.center),
                ],
              );
            }).toList(),
          ),
          Positioned(
            top: 24,
            child: TextButton(
              onPressed: () {
                const SignUpScreen().launch(context);
              },
              child: Text('Skip', style: primaryTextStyle()),
            ),
          ),
          Positioned(
            bottom: 130,
            right: 0,
            left: 0,
            child: DotIndicator(
              indicatorColor: Colors.blueAccent,
              pageController: pageController,
              pages: list,
              currentDotSize: 20,
              //currentBorderRadius: BorderRadius.circular(10),
              boxShape: BoxShape.circle,
              currentDotWidth: 80,
              currentBoxShape: BoxShape.rectangle,
              unselectedIndicatorColor: Colors.grey.shade400,
              onPageChanged: (index) {
                setState(
                  () {
                    currentPage = index;
                  },
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: GestureDetector(
              onTap: () {
                if (currentPage == 2) {
                  const SignUpScreen().launch(context);
                } else {
                  pageController.animateToPage(
                    currentPage + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: CircularBlackDecoration,
                child: Text("Get Started", style: boldTextStyle(color: white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
