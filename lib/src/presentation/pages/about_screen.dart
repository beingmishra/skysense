import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AboutScreen extends StatelessWidget {
  final String bgImage;
  const AboutScreen({super.key, required this.bgImage});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          size: 32,
          color: Color(0xffFDFDFC),
        ).onTap(() {
          Navigator.pop(context);
        }),
      ),
      body: Stack(
        children: [
          Image.asset(
            bgImage,
            fit: BoxFit.cover,
            height: size.height,
            width: size.width,
          ),
          Blur(
            blur: 10,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          child: Text(
                            'About Skysense',
                            style: GoogleFonts.nunito(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: Text(
                            'Skysense is a fun weather app built with love by Rahul Mishra (Beingmishra). It\'s an open-source project, meaning anyone can check out the code and even contribute to make it better!',
                            style: GoogleFonts.nunito(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: Text(
                            'Built with Flutter',
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: Text(
                            'Skysense is built using Flutter, a modern framework for building beautiful apps that work across different platforms (Android and iOS). This allows us to keep the codebase clean and efficient while delivering a great user experience on both platforms.',
                            style: GoogleFonts.nunito(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          delay: const Duration(milliseconds: 700),
                          child: Text(
                            'Open Source Project',
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeInUp(
                          delay: const Duration(milliseconds: 800),
                          child: Text(
                            'We believe in transparency and collaboration. That\'s why Skysense\'s source code is available on Github. This allows anyone to see how the app works, learn from it, and even contribute their own improvements.',
                            style: GoogleFonts.nunito(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          delay: const Duration(milliseconds: 900),
                          child: Text(
                            'Data Source',
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeInUp(
                          delay: const Duration(milliseconds: 1000),
                          child: Text(
                            'Skysense fetches weather data from WeatherAPI.com. It\'s important to note that Skysense does not bear any responsibility for the accuracy of the data displayed. We strive to use reliable sources, but weather can be unpredictable!',
                            style: GoogleFonts.nunito(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          delay: const Duration(milliseconds: 1200),
                          child: Text(
                            'Clear Architecture',
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeInUp(
                          delay: const Duration(milliseconds: 1300),
                          child: Text(
                            'The app is built using a clear architecture pattern with dependency injection. This helps to keep the code organized, maintainable, and easier to test.',
                            style: GoogleFonts.nunito(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          delay: const Duration(milliseconds: 1400),
                          child: Text(
                            'Features',
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeInUp(
                          delay: const Duration(milliseconds: 1500),
                          child: Text(
                            'Skysense offers two key features to help you stay informed about the weather:\n\n* Current Location Weather: See the current weather conditions for your location right at your fingertips. No need to manually enter your city or town.\n\n* Search Functionality: Want to know the weather in a different location? No problem! Use the search feature to find any place in the world and see the current weather data.',
                            style: GoogleFonts.nunito(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          delay: const Duration(milliseconds: 1600),
                          child: Text(
                            'We hope you enjoy using Skysense! If you have any feedback or suggestions, feel free to reach out to the developer through the provided channels on Github.',
                            style: GoogleFonts.nunito(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ).paddingAll(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
