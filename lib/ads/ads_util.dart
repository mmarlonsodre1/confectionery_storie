import 'dart:io';

import 'package:clever_ads_solutions/clever_ads_solutions.dart';
import 'package:flutter/foundation.dart';

void initCasAiAds() {
  CAS.settings.setDebugMode(kDebugMode);
  CAS.settings.setTaggedAudience(Audience.notChildren);
  CAS.settings.setMutedAdSounds(true);
  CAS.settings.allowInterstitialAdsWhenVideoCostAreLower(true);
  var casManager = CAS
      .buildManager()
      .withCasId(Platform.isAndroid ? 'com.sodremr.confectioneryStorie' : '1578785708')
      .withTestMode(kDebugMode)
      .withAdTypes(
        AdTypeFlags.banner | AdTypeFlags.interstitial
        | AdTypeFlags.rewarded | AdTypeFlags.appOpen
      ).withConsentFlow(
      ConsentFlow.create()
          .withPrivacyPolicy('https://sites.google.com/view/ambience-pad/in%C3%ADcio')
      ).build();

  casManager.enableAppReturn(_AppOpenAdCallback());
}

class _AppOpenAdCallback extends AdCallback {
  _AppOpenAdCallback();

  @override
  void onClicked() {}

  @override
  void onClosed() {}

  @override
  void onComplete() {}

  @override
  void onImpression(AdImpression? adImpression) {}

  @override
  void onShowFailed(String? message) {}

  @override
  void onShown() {}
}