enum MacroCategory {
  technology,
  woman,
  man,
  home,
  groceries,
  bike,
  fashion,
  fragrances,
}

extension MacroExtension on MacroCategory {
  //ogni macro categoria ha le sue categorie
  //in futuro => se clicco su una macrocategoria, filtro tutti i prodotti che rientrano in 1 di quelle categorie
  List<String> get categoryByMacro {
    switch (this) {
      case MacroCategory.technology:
        return ["smartphones", "laptops", "automotive"];
      case MacroCategory.woman:
        return [
          "womens-dresses",
          "womens-shoes",
          "womens-watches",
          "womens-bags",
          "womens-jewellery",
          "tops"
        ];
      case MacroCategory.man:
        return ["mens-shirts", "mens-shoes", "mens-watches"];
      case MacroCategory.home:
        return ["home-decoration", "lighting", "furniture"];
      case MacroCategory.groceries:
        return ["groceries"];
      case MacroCategory.bike:
        return ["motorcycle"];
      case MacroCategory.fashion:
        return ["skincare"];
      case MacroCategory.fragrances:
        return ["fragrances"];
    }
  }

  String get name {
    switch (this) {
      case MacroCategory.technology:
        return "Technology";
      case MacroCategory.woman:
        return "Woman";
      case MacroCategory.man:
        return "Man";
      case MacroCategory.home:
        return "Home";
      case MacroCategory.bike:
        return "Bike";
      case MacroCategory.fashion:
        return "Fashion";
      case MacroCategory.groceries:
        return "Groceries";
      case MacroCategory.fragrances:
        return "Fragrances";
    }
  }
}

enum ProductsCategory {
  smartphones,
  laptops,
  fragrances,
  skincare,
  groceries,
  homeDecoration,
  furniture,
  tops,
  womensDresses,
  womensShoes,
  mensShirts,
  mensShoes,
  mensWatches,
  womensWatches,
  womensBags,
  womensJewellery,
  sunglasses,
  automotive,
  motorcycle,
  lighting,
}

extension CategoryExtension on ProductsCategory {
  String get name {
    switch (this) {
      case ProductsCategory.smartphones:
        return "smartphones";
      case ProductsCategory.laptops:
        return "laptops";
      case ProductsCategory.fragrances:
        return "fragrances";
      case ProductsCategory.skincare:
        return "skincare";
      case ProductsCategory.groceries:
        return "groceries";
      case ProductsCategory.homeDecoration:
        return "home-decoration";
      case ProductsCategory.furniture:
        return "furniture";
      case ProductsCategory.tops:
        return "tops";
      case ProductsCategory.womensDresses:
        return "womens-dresses";
      case ProductsCategory.womensShoes:
        return "womens-shoes";
      case ProductsCategory.mensShirts:
        return "mens-shirts";
      case ProductsCategory.mensShoes:
        return "mens-shoes";
      case ProductsCategory.mensWatches:
        return "mens-watches";
      case ProductsCategory.womensWatches:
        return "women-watches";
      case ProductsCategory.womensBags:
        return "women-bags";
      case ProductsCategory.womensJewellery:
        return "womens-jewellery";
      case ProductsCategory.sunglasses:
        return "sunglasses";
      case ProductsCategory.automotive:
        return "automotive";
      case ProductsCategory.motorcycle:
        return "motorcycle";
      case ProductsCategory.lighting:
        return "lighting";
    }
  }
}
