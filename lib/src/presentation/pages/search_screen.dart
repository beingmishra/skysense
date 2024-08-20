import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skysense/src/data/models/search_place_model.dart';
import 'package:skysense/src/presentation/bloc/weather_bloc.dart';

class SearchScreen extends StatefulWidget {
  final String bgImage;
  const SearchScreen({super.key, required this.bgImage});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<SearchPlaceModel> searchItems = [];
  final _debouncer = Debouncer(milliseconds: 500);
  bool isSearching = false;

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
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoading) {
            setState(() {
              isSearching = true;
            });
          }


          if (state is WeatherFailure) {
            toastLong(state.error);
            setState(() {
              isSearching = false;
              searchItems.clear();
            });
          }

          if (state is SearchPlaceSuccess) {
            setState(() {
              isSearching = false;
              searchItems = state.data;
            });
          }
        },
        child: Stack(
          children: [
            Image.asset(widget.bgImage,
              fit: BoxFit.cover,
              height: size.height,
              width: size.width,
            ),
            Container(
              height: size.height,
              width: size.width,
              color: const Color(0xff20242E).withOpacity(0.5),
            ),
            buildSearchView(size)
          ],
        ),
      ),
    );
  }

  buildSearchView(Size size) {
    return Blur(
      blur: 10,
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.4),
            ])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  "Search",
                  style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400),
                ),
              ),
              12.height,
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Container(
                  decoration: boxDecorationRoundedWithShadow(1000),
                  child: TextFormField(
                    onChanged: (val) {
                      _debouncer.run(() {
                        if(val.isNotEmpty) {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(SearchPlaceEvent(query: val));
                        }else{

                        }
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusColor: Colors.grey.shade400,
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              isSearching ? const LinearProgressIndicator(color: Colors.white, backgroundColor: Colors.grey,).paddingOnly(top: 16, left: 12, right: 12) : const SizedBox(),
              16.height,
              Visibility(
                visible: searchItems.isNotEmpty,
                child: Text(
                  "Results",
                  style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: searchItems.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                      ),
                      8.width,
                      Text(
                        "${searchItems[index].name}, ${searchItems[index].country}",
                        style: GoogleFonts.nunito(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xffFDFDFC)),
                      ).expand()
                    ],
                  ).onTap(() {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(GetWeatherEvent(locationName: searchItems[index].name));
                  });
                }, separatorBuilder: (BuildContext context, int index) {
                return 24.height;
              },).expand()
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
