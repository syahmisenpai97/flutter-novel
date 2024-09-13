import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kacs/views/pages/ReadScreen/model/view_model_read_screen.dart';
import 'package:kacs/views/themes/theme_config.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key, required this.readScreen});

  final ViewModelReadScreen readScreen;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        margin: const EdgeInsets.only(top: 30, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.chevron_left_rounded, size: 30)),
            Expanded(
              child: Text(
                readScreen.title,
                style: semiBoldText14.copyWith(
                  color: blackColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Icon(Icons.share_outlined)
          ],
        ),
      );
    }

    Widget novelImage() {
      return Hero(
        tag: readScreen.imageUrl,
        child: Container(
          height: 267,
          width: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(readScreen.imageUrl),
            ),
          ),
        ),
      );
    }

    Widget infoDescription() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: greyColorInfo,
          borderRadius: BorderRadius.circular(9),
        ),
        child: HtmlWidget(readScreen.summary),
      );
    }

    Widget saveButton() {
      return Positioned(
        top: 400,
        right: 40,
        child: Container(
          height: 50,
          width: 50,
          // padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(color: greenColor, shape: BoxShape.circle),
          child: const Center(
            child: Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget description() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: semiBoldText14.copyWith(color: blackColor2),
            ),
            const SizedBox(height: 6),
            // Text(
            //   data['summary'],
            //   style: regularText12.copyWith(color: greyColor),
            // ),
            infoDescription(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  header(),
                  novelImage(),
                  description(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
