import '../../domain/entity/abstract_production_countries.dart';

class ProductionCountriesModel extends AbstractProductionCountries {
  ProductionCountriesModel({
    super.name,
    super.iso_3166_1,
  });

  static List<ProductionCountriesModel> fromList(
    List<dynamic>? productionCountryList,
  ) {
    List<ProductionCountriesModel> productionCountries = [];
    if (productionCountryList != null) {
      productionCountryList.forEach((productionCountry) {
        productionCountries
            .add(ProductionCountriesModel.fromJson(productionCountry));
      });
    }

    return productionCountries;
  }

  factory ProductionCountriesModel.fromJson(Map<String, dynamic> json) {
    return ProductionCountriesModel(
      name: json['name'] as String?,
      iso_3166_1: json['iso_3166_1'] as String?,
    );
  }

  @override
  String toString() {
    return '${name!} (${iso_3166_1!.toUpperCase()})';
  }
}
