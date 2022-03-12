import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get_out1/screens/caller_id.dart';
import 'package:get_out1/screens/scheduler.dart';
import 'package:get_out1/screens/user_manual.dart';
import 'package:get_out1/utilities/card_child.dart';
import 'package:get_out1/utilities/icon_content.dart';
import 'package:get_out1/constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../utilities/ad_helper.dart';
import 'incoming_call.dart';

class CallMenu extends StatefulWidget {
  @override
  State<CallMenu> createState() => _CallMenuState();
}

class _CallMenuState extends State<CallMenu> {
  InterstitialAd? _timerFull;
  bool isFullTimerLoaded = false;

  InterstitialAd? _IDFull;
  bool isFullIDLoaded = false;

  void _initializeFullAdTimer() {
    InterstitialAd.load(
      adUnitId: AdHelper.timerFull(),
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._timerFull = ad;
          isFullTimerLoaded = true;
          _timerFull?.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            Navigator.of(context).pushNamed('/Scheduler');
            //_timerFull?.dispose();
          }, onAdFailedToShowFullScreenContent: (ad, err) {
            print(
                'F-A-I-L-E-D to load full screen TImer Full AD: ${err.message}');
            isFullTimerLoaded = false;
            //_timerFull?.dispose();
          }, onAdImpression: (ad) {
            _initializeFullAdTimer();
          });
        },
        onAdFailedToLoad: (err) {
          _initializeFullAdTimer();
          print('F-A-I-L-E-D to load TImer Full AD: ${err.message}');
          isFullTimerLoaded = false;
        },
      ),
    );
  }

  void _initializeFullAdID() {
    InterstitialAd.load(
      adUnitId: AdHelper.idFull(),
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._IDFull = ad;
          isFullIDLoaded = true;
          _IDFull?.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            Navigator.of(context).pushNamed('/CallerID');
            //_IDFull?.dispose();
          }, onAdFailedToShowFullScreenContent: (ad, err) {
            print('F-A-I-L-E-D to load full screen ID Full AD: ${err.message}');
            isFullIDLoaded = false;
            //_IDFull?.dispose();
          }, onAdImpression: (ad) {
            _initializeFullAdID();
          });
        },
        onAdFailedToLoad: (err) {
          _initializeFullAdID();
          print('F-A-I-L-E-D to load ID Full AD: ${err.message}');
          isFullIDLoaded = false;
        },
      ),
    );
  }

//"5D48E512E9EB0246C16EDCFE865C0E7D"
  @override
  void initState() {
    super.initState();
    _initializeFullAdTimer();
    _initializeFullAdID();
  }

  void playRingtone() {
    FlutterRingtonePlayer.playRingtone(asAlarm: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00001A),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/image4.jpeg",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 60.0, right: 30.0, bottom: 30.0),
              child: Column(children: [
                Text(
                  "Get Me Out",
                  style: kHeadingTextStyle.copyWith(
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Make fake calls for FREE',
                  style: kLightLabelTextStyle.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFECE00),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CardChild(
                              cardChild: IconContent(
                                icon: const IconData(0xeb9f,
                                    fontFamily: 'MaterialIcons'),
                                text: "Call Now",
                              ),
                              onPress: () {
                                playRingtone();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IncomingCall(
                                      name: "Unknown",
                                      number: "(410) 0679 890",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: CardChild(
                              cardChild: IconContent(
                                icon: const IconData(0xe18c,
                                    fontFamily: 'MaterialIcons'),
                                text: 'Caller ID',
                              ),
                              onPress: () {
                                if (isFullIDLoaded) {
                                  _IDFull?.show();
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CallerID()),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child: CardChild(
                            cardChild: IconContent(
                              icon: const IconData(0xe316,
                                  fontFamily: 'MaterialIcons'),
                              text: "Schedule",
                            ),
                            onPress: () {
                              if (isFullTimerLoaded) {
                                _timerFull?.show();
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Scheduler()),
                                );
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: CardChild(
                            cardChild: IconContent(
                              icon: const IconData(0xe4fa,
                                  fontFamily: 'MaterialIcons'),
                              text: "FAQ",
                            ),
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserManual()),
                              );
                            },
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
