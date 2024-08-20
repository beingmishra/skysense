import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skysense/src/domain/entities/weather_data_entity.dart';

class HourlyViewWidget extends StatelessWidget {
  final CurrentEntity data;
  final int tempUnit;
  const HourlyViewWidget({super.key, required this.data, required this.tempUnit});

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 10,
      child: Container(
        decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.2),
            ])),
        padding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          children: [
            Text(
              data.time == null
                  ? "-"
                  : DateFormat("h a")
                  .format(DateTime.parse(data.time!)),
              style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xffFDFDFC)),
            ),
            4.height,
            Image.network(
              "https:${data.condition.icon}",
              height: 42,
            ),
            4.height,
            Text(
              tempUnit == 0 ? "${data.tempC}°" : "${data.tempF}°",
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xffFDFDFC)),
            ),
          ],
        ),
      ),
    );
  }
}
