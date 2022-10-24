import '../../domain/entity/abstract_collection.dart';

class CollectionModel extends AbstractCollection {
  CollectionModel({
    super.id,
    super.name,
    super.posterPath,
    super.backdropPath,
  });

  static CollectionModel? fromMap(
    Map<String, dynamic>? collection,
  ) {
    return collection != null ? CollectionModel.fromJson(collection) : null;
  }

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
    );
  }
}
