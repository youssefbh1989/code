import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../models/slider_model.dart';
import '../services/api.dart';

class Banners extends StatelessWidget {
  final List<SliderModel> slider;

  const Banners({Key key, this.slider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: slider.length,
      itemBuilder: (context, index, realIndex) => SizedBox(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: slider[index] == null
                ? _shimmer()
                : CachedNetworkImage(
              imageUrl: 'https://salonat.qa/${(slider[index].image)}',
              progressIndicatorBuilder: (_, __, ___) {
                return _shimmer();
              },
              errorWidget: (_, __, ___) => Container(
                width: double.infinity,
                height: double.infinity,
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 15.sp,
                ),
              ),
              fit: BoxFit.fill, // set the fit property to BoxFit.cover
            ),
          ),
        ),
      ),
      options: CarouselOptions(
        height: API.isPhone ? 150.0 : 260.0,
        enlargeCenterPage: true,
        autoPlay: true,
        disableCenter: true,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
        pauseAutoPlayInFiniteScroll: true,
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: .98,
        pauseAutoPlayOnManualNavigate: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
    );
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red,
        ),
        baseColor: Colors.transparent,
        highlightColor: Colors.white);
  }
}
