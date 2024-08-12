import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarWidget("Search", 
          center: true,
          elevation: 0, color: Colors.transparent),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                stops: [0,1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffacdaf1),
                  Color(0xff6fc4ad),
                ])
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: boxDecorationRoundedWithShadow(16),
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search here",
                      contentPadding: EdgeInsets.only(top: 15)
                  ),
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                return const ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  leading: Icon(Icons.location_on),
                  title: Text("Zirakpur"),
                );
              })
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
