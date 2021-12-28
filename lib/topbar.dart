import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class TopBar extends StatelessWidget {
  const TopBar({Key? key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Image(
              image: AssetImage('avatar.png'),
              height: 512,
              width: 512,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 64.0,
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontFamily: GoogleFonts.getFont('Hind').fontFamily,
                ),
                child: AnimatedTextKit(
                  repeatForever: false,
                  displayFullTextOnTap: false,
                  animatedTexts: [
                    TypewriterAnimatedText('I\'m Pratik Bedre',
                        cursor: '_', speed: const Duration(milliseconds: 100)),
                  ],
                  onTap: () {},
                ),
              ),
            )
          ]),
    );
  }
}
