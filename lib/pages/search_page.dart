import 'package:ecommerce_app/models/products_category.dart';
import 'package:ecommerce_app/pages/all_product_page.dart';
import 'package:flutter/material.dart';

//pagina con le categorie varie, quando premo mi va su

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: MacroCategory.values
          .map(
            //per ogni elemento in MacroCategory è un expansion Tile !
            (macroCategory) => _buildExpansionTile(context, macroCategory),
          )
          .toList(),
    );
  }

  Widget _buildExpansionTile(
          BuildContext context, MacroCategory macroCategory) =>
      Card(
        elevation: 4.0,
        child: ExpansionTile(
          title: Text(macroCategory.name),
          children: macroCategory.categoryByMacro
              .map(
                //per ogni expansionTile ci sono varie categorie, click => guardo i prodotti di quella categoria
                (categoryName) => _buildSingleElement(context, categoryName),
              )
              .toList(),
        ),
      );

  Widget _buildSingleElement(BuildContext context, String categoryName) =>
      ListTile(
        title: Text(categoryName),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AllProductPage(
              category: categoryName,
            ),
          ),
        ),
      );
}
