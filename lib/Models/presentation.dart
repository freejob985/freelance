// ignore_for_file: public_member_api_docs, sort_constructors_first
class presentation {
  final int? id;
  final String Semantic_word;
  final String offer;

  presentation({
    this.id,
    required this.Semantic_word,
    required this.offer,
  });

  factory presentation.fromMap(Map<String, dynamic> json) => presentation(
        id: json['id'],
        Semantic_word: json['Semantic_word'],
        offer: json['offer'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Semantic_word': Semantic_word,
      'offer': offer,
    };
  }

  factory presentation.fromJson(Map<String, dynamic> json) {
    return presentation(
      id: json['id'],
      Semantic_word: json['Semantic_word'],
      offer: json['offer'],
    );
  }
}
