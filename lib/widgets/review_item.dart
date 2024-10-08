import 'package:flutter/material.dart';

String dummyImageUrl =
    "https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj";

class ReviewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                  child: Image.network(dummyImageUrl,
                      width: 50, height: 50, fit: BoxFit.cover)),
              const SizedBox(width: 5),
              const Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("User Name",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey)),
                    Row(children: [
                      Icon(Icons.star_border,
                          color: Color(0xFFFF8700), size: 16),
                      SizedBox(width: 2),
                      Text("9.0",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              height: 1.5,
                              color: Color(0xFFFF8700)))
                    ])
                  ],
                ),
              ),
              const Text("2021-10-9")
            ],
          ),
          const SizedBox(height: 5),
          Text(dummyImageUrl)
        ],
      ),
    );
  }
}
