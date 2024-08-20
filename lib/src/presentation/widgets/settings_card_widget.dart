import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingsCardWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTapEvent;
  const SettingsCardWidget({super.key, required this.iconData, required this.title, required this.onTapEvent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapEvent,
      child: Container(
        decoration: boxDecorationRoundedWithShadow(100),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(iconData, size: 20),
            4.width,
            Text(title, style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
