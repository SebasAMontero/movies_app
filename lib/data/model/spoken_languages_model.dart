import '../../domain/entity/abstract_spoken_languages.dart';

class SpokenLanguagesModel extends AbstractSpokenLanguages {
  SpokenLanguagesModel({
    super.name,
    super.iso_639_1,
    super.englishName,
  });

  static List<SpokenLanguagesModel> fromList(
    List<dynamic>? spokenLanguagesList,
  ) {
    List<SpokenLanguagesModel> spokenLanguages = [];

    if (spokenLanguagesList != null) {
      spokenLanguagesList.forEach((spokenLanguage) {
        spokenLanguages.add(SpokenLanguagesModel.fromJson(spokenLanguage));
      });
    }
    return spokenLanguages;
  }

  factory SpokenLanguagesModel.fromJson(Map<String, dynamic> json) {
    return SpokenLanguagesModel(
      name: json['name'] as String?,
      iso_639_1: json['iso_639_1'] as String?,
      englishName: json['english_name'] as String?,
    );
  }

  @override
  String toString() {
    return '${englishName!} (${iso_639_1!.toUpperCase()})';
  }
}
