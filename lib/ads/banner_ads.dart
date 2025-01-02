import 'package:clever_ads_solutions/clever_ads_solutions.dart' as cas;
import 'package:flutter/material.dart';

class BannerAds extends StatelessWidget {
  const BannerAds({super.key});

  @override
  Widget build(BuildContext context) {
    return cas.BannerWidget(
      isAutoloadEnabled: true,
      size: cas.AdSize.getInlineBanner(
        MediaQuery.sizeOf(context).width.toInt(),
        60,
      ),
    );
  }
}
