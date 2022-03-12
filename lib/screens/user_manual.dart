import 'package:flutter/material.dart';
import 'package:get_out1/constants.dart';

class UserManual extends StatelessWidget {
  const UserManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //color: const Color(0xFF00001A),
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: const AssetImage(
                    "assets/images/image5.jpeg",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '➊ What does the app do?',
                  style: kHeadingTextStyle.copyWith(
                      color: const Color(0xFFFECE00),
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'It\'s a prank app. You can receive fake calls by clicking a button '
                  'or setting a timer. You can also add the contact details of your choice.',
                  style: kHeadingTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  '➋ For how long the call be active?',
                  style: kHeadingTextStyle.copyWith(
                      color: const Color(0xFFFECE00),
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'As long as you want unless and until you press the cancel button.',
                  style: kHeadingTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  '➌ Can I lock the screen after setting the timer?',
                  style: kHeadingTextStyle.copyWith(
                      color: const Color(0xFFFECE00),
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Yes, you can do that. As soon as the time is up, you '
                  'will hear your caller tune, but no calling screen will be visible.'
                  'The calling screen will only be visible after you unlock the phone.\n'
                  'PS: You have to be on the timer screen.',
                  style: kHeadingTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  '➍ Will I receive a call if I set the timer and let the app run in the background?',
                  style: kHeadingTextStyle.copyWith(
                      color: const Color(0xFFFECE00),
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Yes, you will receive the call. You will only hear the caller'
                  'tune first, and then on clicking the app in the background you will be able to see the calling screen.',
                  style: kHeadingTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  '➎ Can I make a gesture to receive fake calls?',
                  style: kHeadingTextStyle.copyWith(
                      color: const Color(0xFFFECE00),
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'No. Currently your android operating system won\'t allow that. But maybe in the future'
                  ' we will add that functionality.',
                  style: kHeadingTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
