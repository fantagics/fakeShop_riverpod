import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../resources/color_asset/colors.dart';
import '../../../service/procucts_provider.dart';

class BannerAutoSlider extends ConsumerStatefulWidget {
	const BannerAutoSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BannerAutoSlider();
}

class _BannerAutoSlider extends ConsumerState<BannerAutoSlider> {
  int eventIdx = 0;

  @override
  Widget build(BuildContext context) {
    final eventImg = ref.watch(eventsImgProvider);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 16/9,
            initialPage: 0,
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                eventIdx  = index;
              });
            },
          ),
          itemCount: eventImg.length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () { print(index); },
              child: Image.asset(eventImg[index]),
            );
          },
        ),
        Padding(padding: EdgeInsets.only(bottom: 10),
          child: AnimatedSmoothIndicator(
            activeIndex: eventIdx, 
            count: eventImg.length,
            effect: WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              dotColor: Colors.grey.withOpacity(0.6),
              activeDotColor: CsColors.cs.accentColor
            ),
          ),
        ),
      ],
    );
  }
}