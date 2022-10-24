import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/util/service_constants.dart';
import '../../../../core/util/string_constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection(StringConstants.mainFirebaseCollection);
final CollectionReference _mainCollectionDetail =
    _firestore.collection(StringConstants.mainFirebaseCollectionDetails);

class Database {
  Future<void> addMovies({
    required List<dynamic> movies,
    required String mainCollectionDocument,
    required String subCollection,
  }) async {
    WriteBatch batch = _firestore.batch();
    movies.forEach((movie) {
      DocumentReference documentReferencer = _mainCollection
          .doc(mainCollectionDocument)
          .collection(subCollection)
          .doc(movie[ServiceConstants.movieId].toString());
      batch.set(
        documentReferencer,
        movie,
        SetOptions(merge: true),
      );
    });
    batch.commit();
  }

  Future<void> addMovieDetail({
    required Map<String, dynamic> movie,
  }) async {
    WriteBatch batch = _firestore.batch();

    DocumentReference documentReferencer = _mainCollectionDetail.doc(
      movie[ServiceConstants.movieId].toString(),
    );
    batch.set(
      documentReferencer,
      movie,
      SetOptions(merge: true),
    );

    batch.commit();
  }

  Future<QuerySnapshot> readMovies({
    required String mainCollectionDocument,
    required String subCollection,
  }) async {
    CollectionReference moviesCollection =
        _mainCollection.doc(mainCollectionDocument).collection(subCollection);
    var response = await moviesCollection.get();
    return response;
  }

  Future<DocumentSnapshot> readMovieDetail({
    required String id,
  }) async {
    final DocumentReference movieDetailCollection =
        _mainCollectionDetail.doc(id);
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    final DocumentReference movieItemCollection = movieDetailCollection;
    var response = await movieItemCollection.get();
    return response;
  }

  Future<List<QuerySnapshot>> searchMovies({
    required String keyword,
  }) async {
    List<QuerySnapshot> results = [];

    results.add(
      await searchInCollection(
        collection: ServiceConstants.upcomingCollection,
        keyword: keyword,
      ),
    );
    results.add(
      await searchInCollection(
        collection: ServiceConstants.nowPlayingCollection,
        keyword: keyword,
      ),
    );
    results.add(
      await searchInCollection(
        collection: ServiceConstants.topRatedCollection,
        keyword: keyword,
      ),
    );

    return results;
  }

  Future<QuerySnapshot> searchInCollection({
    required String collection,
    required String keyword,
  }) {
    return _mainCollection
        .doc(
          '$collection${ServiceConstants.collectionDocumentModifier}',
        )
        .collection(collection)
        .where(
          StringConstants.dbSearchField,
          isGreaterThanOrEqualTo: keyword.toLowerCase(),
        )
        .where(
          StringConstants.dbSearchField,
          isLessThanOrEqualTo: '${keyword.toLowerCase()}\uf8ff',
        )
        .get();
  }
}
