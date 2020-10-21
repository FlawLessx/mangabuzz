class RatingCheck {
  double ratingCheck(String rating) {
    if (rating == '?' || rating == 'N/A' || rating == '-')
      return 0;
    else if (rating.contains(',')) {
      var data = rating.replaceAll(RegExp(r','), '.');
      return double.parse(data) / 2;
    } else
      return double.parse(rating) / 2;
  }
}
