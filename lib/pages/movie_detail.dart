import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/utils/app_colors.dart';
import 'package:flutter_flix/utils/app_size.dart';
import 'package:flutter_flix/utils/app_string.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: darkBg,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/back.png",
                          width: iconSize, height: iconSize, fit: BoxFit.cover),
                      const Text("Detail",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                              height: 1.5,
                              color: Colors.white)),
                      Image.asset("assets/images/marked.png",
                          width: iconSize, height: iconSize, fit: BoxFit.cover)
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0)),
                        child: Image.network(movieBgUrl,
                            width: double.infinity,
                            height: 210,
                            fit: BoxFit.cover)),
                    Positioned(
                      bottom: 10,
                      right: 20,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                          child: Container(
                            width: 54,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              // Màu nền mờ
                              borderRadius: BorderRadius.circular(
                                  8), // Bo tròn góc nếu cần
                            ),
                            alignment: Alignment.center,
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_border,
                                      color: Color(0xFFFF8700), size: 16),
                                  SizedBox(width: 3),
                                  Text(
                                    '9.5',
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        height: 1.5,
                                        color: Color(0xFFFF8700)),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: -60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(movieThumbUrl,
                            width: 95, height: 120),
                      ),
                    ),
                    const Positioned(
                      bottom: -60,
                      left: 140,
                      child: SizedBox(
                        width: 210,
                        child: Text("Spiderman No Way Home",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: Colors.white)),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 90),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/calendar.png",
                        width: 16, height: 16, fit: BoxFit.cover),
                    const SizedBox(width: 3),
                    const Text("2021",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: textGray,
                            height: 1.2)),
                    const SizedBox(width: 5),
                    Container(width: 1, height: 16, color: textGray),
                    const SizedBox(width: 5),
                    Image.asset('assets/images/clock.png'),
                    const SizedBox(width: 3),
                    const Text("148 minutes",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: textGray,
                            height: 1.2)),
                    const SizedBox(width: 5),
                    Container(width: 1, height: 16, color: textGray),
                    const SizedBox(width: 5),
                    Image.asset('assets/images/ticket.png'),
                    const SizedBox(width: 3),
                    const Text("Action",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: textGray,
                            height: 1.2)),
                  ],
                ),
                const DefaultTabController(
                    length: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TabBar(
                            isScrollable: true,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(
                                child: Text("About Movie",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    textAlign: TextAlign.center),
                              ),
                              Tab(
                                child: Text("Reviews",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    textAlign: TextAlign.center),
                              ),
                              Tab(
                                child: Text("Cast",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    textAlign: TextAlign.center),
                              )
                            ])
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
