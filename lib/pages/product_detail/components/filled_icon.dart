import 'package:flutter/material.dart';

import '../../../theme.dart';

//star incons for rating
class FilledIcon extends StatelessWidget {
  final double prodRating;
  const FilledIcon({
    Key? key,
    required this.prodRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getIcons(prodRating.truncate()),
    );
  }

  List<Widget> getIcons(int numIcons) {
    List<Widget> results = [];
    //icone piene
    for (int i = 0; i < numIcons; i++) {
      results.add(
        const Icon(
          Icons.star,
          color: AppColor.lightColor,
        ),
      );
    }
    //icona a metà
    final double ciao = double.parse((prodRating % 1).toStringAsFixed(2));
    if (ciao > 0.0) {
      numIcons++;
      results.insert(
        results.length,
        const Icon(
          Icons.star_half,
          color: AppColor.lightColor,
        ),
      );
    }

    //icone bianche
    final numIconeBianche = 5 - numIcons;
    for (int i = 0; i < numIconeBianche; i++) {
      results.insert(
        results.length,
        Icon(
          Icons.star,
          color: AppColor.lightColor.withOpacity(0.5),
        ),
      );
    }
    return results;
  }
}
