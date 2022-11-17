import 'package:flutter/material.dart';
import '../../db/supa_handler.dart';
import 'components/custom_future_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

//ora i prodotti li prendo dal database !
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            //* mostro prodotti in sconto
            child: CustomFutureBuilder(
              dbRequest: SupaHandler().getDiscountProducts(),
              text: "Discount",
            ),
          ),
          //* padding
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            //* mostro prodotti popolari (top rated)
            child: CustomFutureBuilder(
              dbRequest: SupaHandler().getPopularProducts(),
              text: "Top Rated",
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      );
}
