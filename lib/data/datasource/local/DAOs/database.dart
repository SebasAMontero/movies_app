import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/util/string_constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection(StringConstants.mainFirebaseCollection);

class Database {
  Future<void> addMovie({
    required List<dynamic> movies,
    required String mainCollectionDocument,
    required String subcollection,
  }) async {
    WriteBatch batch = _firestore.batch();
    movies.forEach((movie) {
      DocumentReference documentReferencer = _mainCollection
          .doc(mainCollectionDocument)
          .collection(subcollection)
          .doc(movie['id'].toString());
      batch.set(
        documentReferencer,
        movie,
        SetOptions(merge: true),
      );
    });
    batch.commit();
  }

  Future<QuerySnapshot> readMovies({
    required String mainCollectionDocument,
    required String subcollection,
  }) async {
    CollectionReference moviesCollection =
        _mainCollection.doc(mainCollectionDocument).collection(subcollection);
    var response = await moviesCollection.get();
    return response;
  }
}
