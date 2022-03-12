import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants.dart';
import '../utilities/ad_helper.dart';
import 'incoming_call.dart';

class Scheduler extends StatefulWidget {
  static const routeName = '/Scheduler';
  const Scheduler({Key? key}) : super(key: key);

  @override
  _SchedulerState createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  int mins = 0;
  int sec = 0;
  String name = "UNKNOWN";
  String number = "(410) 0679 890";
  late BannerAd _timerBanner;
  bool isTimerBannerLoaded = false;

  void _createTimerBanner() {
    _timerBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.timerBanner(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isTimerBannerLoaded = true;
        });
      }, onAdFailedToLoad: (ad, err) {
        print("F-A-I-L-E-D to load banner ${err.message}");
        isTimerBannerLoaded = false;
        ad.dispose();
      }),
      request: AdRequest(),
    );
    _timerBanner.load();
  }

  @override
  void initState() {
    super.initState();
    _createTimerBanner();
  }

  @override
  void dispose() {
    _timerBanner.dispose();
    super.dispose();
  }

  scheduleCall(int sec, String name, String number) {
    Duration schedule = Duration(seconds: sec);
    Future.delayed(schedule, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IncomingCall(
            name: name,
            number: number,
          ),
        ),
      );
      FlutterRingtonePlayer.playRingtone(asAlarm: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: isTimerBannerLoaded
          ? Container(
              height: _timerBanner.size.height.toDouble(),
              width: _timerBanner.size.width.toDouble(),
              child: AdWidget(
                ad: _timerBanner,
              ))
          : null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/image4.jpeg",
              ),
              fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 140.0, 30.0, 120.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.black,
                      ),
                      child: Center(
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            hintText: "min",
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                          textAlign: TextAlign.center,
                          controller: hourController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 80,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.black,
                      ),
                      child: Center(
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            hintText: "sec",
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                          textAlign: TextAlign.center,
                          controller: minuteController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: SizedBox(
                    height: 1.0,
                  ),
                ),
                Text(
                  "Name",
                  style: kHeadingTextStyle.copyWith(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  style: const TextStyle(
                    color: Color(0xFFFECE00),
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: const InputDecoration(
                    //contentPadding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Number",
                  style: kHeadingTextStyle.copyWith(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  style: const TextStyle(
                    color: const Color(0xFFFECE00),
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    number = value;
                  },
                  decoration: const InputDecoration(
                    //contentPadding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    height: 1.0,
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    'Set Timer',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    if (hourController.text.isEmpty) {
                      hourController.text = '0';
                    }
                    mins = int.parse(hourController.text);
                    sec = int.parse(minuteController.text);
                    sec = mins * 60 + sec;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text(
                                'Note',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              content: const Text(
                                  'You have to be on this screen to receive the call or'
                                  ' you can press the home button and let the app run in the background. '
                                  'When the time is up you will hear the caller tune, after clicking the '
                                  'app in the background you will be able to see the calling screen.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    scheduleCall(sec, name, number);
                                  },
                                  child: const Text("OK"),
                                  style: TextButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                ),
                              ]);
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFECE00),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                //scheduleCall(sec),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
