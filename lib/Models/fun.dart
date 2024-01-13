// ignore_for_file: public_member_api_docs, sort_constructors_first
class Fun {
  final int? id;
  final String words;
  final String timex;
  final String datex;
  final String functionx;

  Fun({
    this.id,
    required this.words,
    required this.timex,
    required this.datex,
    required this.functionx,
  });

  factory Fun.fromMap(Map<String, dynamic> json) => Fun(
        id: json['id'],
        words: json['words'],
        timex: json['timex'],
        datex: json['datex'],
        functionx: json['functionx'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'words': words,
      'timex': timex,
      'datex': datex,
      'functionx': functionx,
    };
  }

  factory Fun.fromJson(Map<String, dynamic> json) {
    return Fun(
      id: json['id'],
      words: json['words'],
      timex: json['timex'],
      datex: json['datex'],
      functionx: json['functionx'],
    );
  }
}
