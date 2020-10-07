import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Rating extends StatelessWidget {
  final String rating;
  Rating({@required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBarIndicator(
            rating: double.parse(rating) / 2,
            itemCount: 5,
            itemSize: ScreenUtil().setHeight(40),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Text(
            rating,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          )
        ]);
  }
}
