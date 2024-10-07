import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';

import '../models/movie.dart';

class WatchListMovieItem extends StatelessWidget {
  final Movie? movie;
  final onTap;

  const WatchListMovieItem(this.movie, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(imageHttp + (movie?.posterPath ?? ""),
                    width: 95, height: 120, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(movie?.name ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.star_border,
                              size: 13, color: Color(0xFFFF8700)),
                          const SizedBox(width: 3),
                          Text(movie?.rate?.toStringAsFixed(1) ?? "",
                              style: const TextStyle(
                                  color: Color(0xFFFF8700),
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  height: 1.2,
                                  fontWeight: FontWeight.w600))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/ticket_w.png",
                              width: 13, height: 13, fit: BoxFit.cover),
                          const SizedBox(width: 3),
                          const Text("Action",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/calendar_w.png",
                              width: 13, height: 13, fit: BoxFit.cover),
                          const SizedBox(width: 3),
                          Text(movie?.releaseDate?.substring(0,4) ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/clock_w.png",
                              width: 13, height: 13, fit: BoxFit.cover),
                          const SizedBox(width: 3),
                          const Text("139 minutes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400))
                        ])
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
