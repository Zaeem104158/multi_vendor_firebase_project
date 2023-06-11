import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class FullImageScreen extends StatefulWidget {
  final List<String>? imageFileList;
  final int? activeImage;
  FullImageScreen({this.imageFileList, this.activeImage});

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  late PageController _pageController;
  int activePage = 1;
  @override
  void initState() {
    super.initState();
    activePage = widget.activeImage!;
    _pageController =
        PageController(viewportFraction: 0.7, initialPage: activePage);
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextComponet(
          textTitle: "Full Image",
          fontWeight: regularBoldFontWeight,
          fontColor: blackColor,
          isCenterText: true,
          isClickAble: false,
          fontSize: mediumTextSize,
        ),
        backgroundColor: whiteColor,
        leading: CustomIconButtonComponet(
          icon: Icons.arrow_back_ios_new,
          iconColor: blackColor,
          onPressed: () {
            navigationPop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedContainer(
              curve: Curves.easeInOutCubic,
              margin: EdgeInsets.all(10),
              duration: Duration(milliseconds: 500),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: CachedNetworkImage(
                    imageUrl: widget.imageFileList![activePage],
                    color: Colors.black.withOpacity(0.2),
                    colorBlendMode: BlendMode.darken,
                    // height: 100,
                    // width: 100,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                                //height: 80,
                                child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    color: redColor.withOpacity(0.3)),
                              ),
                            )),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(
            height: customHeightWidth(context, height: true) / 8,
          ),
          SizedBox(
            width: customHeightWidth(context, height: true),
            height: customHeightWidth(context, height: true) / 4,
            child: PageView.builder(
                clipBehavior: Clip.none,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemCount: widget.imageFileList!.length,
                pageSnapping: true,
                itemBuilder: (context, pagePosition) {
                  bool active = pagePosition == activePage;
                  double margin = active ? 10 : 20;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      curve: Curves.easeInOutCubic,
                      margin: EdgeInsets.all(margin),
                      duration: Duration(milliseconds: 500),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: CachedNetworkImage(
                            imageUrl: widget.imageFileList![pagePosition],
                            color: Colors.black.withOpacity(0.2),
                            colorBlendMode: BlendMode.darken,
                            // height: 100,
                            // width: 100,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                                        //height: 80,
                                        child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: redColor.withOpacity(0.3)),
                                      ),
                                    )),
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                }),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(widget.imageFileList!.length, activePage)),
        ],
      ),
    );
  }
}
