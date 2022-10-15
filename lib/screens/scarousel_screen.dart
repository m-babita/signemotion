import 'package:flutter/material.dart';
import 'package:signemotion/dl_model/carousalModel.dart';
import 'package:signemotion/screens/emotion_screen.dart';
import 'package:signemotion/screens/sign_screen.dart';
import 'package:signemotion/widgets/customizedBtn.dart';

class SCarousel extends StatefulWidget {
  const SCarousel({super.key});

  @override
  State<SCarousel> createState() => _SCarouselState();
}

class _SCarouselState extends State<SCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[200],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  "Basic Gestures",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: PageView.builder(
                  itemCount: sList.length,
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return customView(index);
                  },
                ),
              ),
              CustomizedBtn(
                btnColor: Colors.purple[200],
                btnTxt: "Try it Yourself",
                txtColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SingnScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget customView(int index) {
  return customCard(sList[index]);
}

Widget customCard(DataModel data) {
  return Column(
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage(
                      data.imageName,
                    ),
                    fit: BoxFit.fill),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.deepPurple)
                ]),
          ),
        ),
      ),
    ],
  );
}
