import '../../domain/entity/abstract_production_companies.dart';

class ProductionCompaniesModel extends AbstractProductionCompanies {
  ProductionCompaniesModel({
    super.id,
    super.name,
    super.originCountry,
    super.logoPath,
  });

  static List<ProductionCompaniesModel> fromList(
    List<dynamic>? productionCompanyList,
  ) {
    List<ProductionCompaniesModel> productionCompanies = [];
    if (productionCompanyList != null) {
      productionCompanyList.forEach((productionCompany) {
        productionCompanies
            .add(ProductionCompaniesModel.fromJson(productionCompany));
      });
    }
    return productionCompanies;
  }

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompaniesModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      originCountry: json['origin_country'] as String?,
      logoPath: json['logo_path'] as String?,
    );
  }

  @override
  String toString() {
    String response = logoPath != null ? '$name#$logoPath' : '$name';
    return response;
  }
}
