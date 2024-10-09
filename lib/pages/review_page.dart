import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';
import 'package:flutter_flix/models/review.dart';
import 'package:flutter_flix/providers/reivews_provider.dart';
import 'package:flutter_flix/values/app_colors.dart';
import 'package:flutter_flix/widgets/tool_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/theme_manager.dart';

String dummyUrl =
    "https://mediaproxy.tvtropes.org/width/1200/https://static.tvtropes.org/pmwiki/pub/images/1000011028.jpg";

class ReviewPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  double mRating = 0.0;
  final String avatarUrl = "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png";
  Movie? movie;
  ReviewPage({super.key, this.movie});

  bool onSend(BuildContext context) {
    if(_controller.text == "") {
      return false;
    }

    Review review = Review(
      id: 12,
      createdAt: DateTime.now().toString(),
      content: _controller.text,
      author: Author(
        avatarPath: avatarUrl,
        rating: mRating,
        username: "User Name"
      )
    );

    context.read<ReviewProvider>().addReview(review);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeManager>().themeMode == ThemeMode.dark;
    String iconBack =
        isDark ? "assets/images/back.png" : "assets/images/back_b.png";
    Color textColor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ToolBar(iconBack, "Review", null, leftIconTap: () {
                Navigator.pop(context);
              }),
              const SizedBox(height: 20),
              Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(imageUrl: imageHttp + (movie?.posterPath ?? ""), height: 140, width: 90))),
              const SizedBox(height: 5),
              Center(
                child: Text(movie?.name ?? "",
                    style: TextStyle(
                        color: textColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        decoration: TextDecoration.none)),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  color: isDark ? inputBg : Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                              child: CachedNetworkImage(imageUrl:  avatarUrl,
                                  width: 50, height: 50, fit: BoxFit.cover)),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("User's Name",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: textColor)),
                              RatingBar.builder(
                                initialRating: mRating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  mRating = rating;
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        child: TextField(
                          controller: _controller,
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Enter your review",
                              hintStyle: const TextStyle(
                                  color: hintColor,
                                  fontSize: 14,
                                  height: 1.5,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400),
                              filled: true,
                              fillColor:
                                  isDark ? Colors.grey : const Color(0xFFF5F5DC)),
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 14,
                            height: 1.5,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          onSend(context);
                          Navigator.pop(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: isDark
                                ? Colors.blueGrey
                                : const Color(0xFFF5F5DC),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Send"),
                                SizedBox(width: 5),
                                Icon(Icons.send, size: 16)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
