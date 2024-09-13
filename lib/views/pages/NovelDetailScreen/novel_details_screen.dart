import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kacs/views/pages/ReadScreen/model/view_model_read_screen.dart';
import 'package:kacs/views/pages/ReadScreen/read_screen.dart';
import 'package:kacs/views/themes/theme_config.dart';

class NovelDetailsScreen extends StatelessWidget {
  const NovelDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map;
    Widget header() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.chevron_left_rounded, size: 30)),
            Text(
              'Novel Details',
              style: semiBoldText14.copyWith(
                color: blackColor,
              ),
            ),
            const Icon(Icons.share_outlined)
          ],
        ),
      );
    }

    Widget novelImage() {
      return Hero(
        tag: data['imageUrl'],
        child: Container(
          height: 267,
          width: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(data['imageUrl']),
            ),
          ),
        ),
      );
    }

    Widget infoDescription() {
      return Container(
        height: 60,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: greyColorInfo,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Publication',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                const SizedBox(height: 2),
                Text(
                  data['publication'].toString(),
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
            VerticalDivider(color: dividerColor, thickness: 1),
            Column(
              children: [
                Text(
                  'Rating',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                const SizedBox(height: 2),
                Text(
                  data['ratings'].toString(),
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
            VerticalDivider(color: dividerColor, thickness: 1),
            Column(
              children: [
                Text(
                  'Genre',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                const SizedBox(height: 2),
                Text(
                  data['genre'].toString().toUpperCase(),
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
          ],
        ),
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

    Widget bottonReadNow() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () {
            ViewModelReadScreen novelread = ViewModelReadScreen(
              title: data['title'],
              imageUrl: data['imageUrl'],
              summary: data['summary'],
            );

            Get.to(() => ReadScreen(readScreen: novelread));
          },
          style: TextButton.styleFrom(
            backgroundColor: greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Read Now',
            style: semiBoldText20.copyWith(color: whiteColor),
          ),
        ),
      );
    }

    Widget description() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: semiBoldText20.copyWith(color: blackColor2),
                      ),
                      Text(
                        data['author'],
                        style: mediumText14.copyWith(color: greyColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                // Text(
                //   'Free Access',
                //   style: mediumText14.copyWith(color: greenColor),
                // ),
              ],
            ),
            const SizedBox(height: 10),
            infoDescription(),
            bottonReadNow(),
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
              saveButton(),
            ],
          )
        ],
      ),
    );
  }
}
