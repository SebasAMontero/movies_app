abstract class AbstractCollection {
  AbstractCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;
}
