import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';

import '../models/review.dart';

class ReviewItem extends StatelessWidget {
  final Review review;

  const ReviewItem(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    String? avatarPath =
        (review.author?.avatarPath?.startsWith("https") ?? false)
            ? review.author?.avatarPath
            : (imageHttp + (review.author!.avatarPath ?? ""));
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                  child: CachedNetworkImage(
                imageUrl:  avatarPath ?? "",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Image.asset('assets/images/flutter_icon.png',
                      width: 50, height: 50);
                },
              )),
              const SizedBox(width: 5),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.author?.username ?? "",
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey)),
                    Row(children: [
                      const Icon(Icons.star_border,
                          color: Color(0xFFFF8700), size: 16),
                      const SizedBox(width: 2),
                      Text(review.author?.rating.toString() ?? "",
                          style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              height: 1.5,
                              color: Color(0xFFFF8700)))
                    ])
                  ],
                ),
              ),
              Text(review.createdAt?.substring(0, 10) ?? "")
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(width: double.infinity, child: Text(review.content ?? ""))
        ],
      ),
    );
  }
}
