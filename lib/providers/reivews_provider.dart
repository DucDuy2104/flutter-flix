import 'package:flutter/cupertino.dart';

import '../models/review.dart';

class ReviewProvider with ChangeNotifier {
  List<Review> mReviews = [];

  void setReviews(List<Review> reviews) {
    mReviews = reviews;
    notifyListeners();
  }

  void addReview(Review review) {
    mReviews.insert(0, review);
    notifyListeners();
  }
}