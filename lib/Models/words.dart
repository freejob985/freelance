// ignore_for_file: public_member_api_docs, sort_constructors_first
class wordsapp {
  final int? id;
  final String words;


  wordsapp({
    this.id,
    required this.words,



  });

  factory wordsapp.fromMap(Map<String, dynamic> json) => wordsapp(
        id: json['id'],
 words: json['words'],



      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
 'words': words,




    };
  }



  factory wordsapp.fromJson(Map<String, dynamic> json) {
    return wordsapp(
           id: json['id'],
        words: json['words'],
    );
  }



}
