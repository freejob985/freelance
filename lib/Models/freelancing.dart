// ignore_for_file: public_member_api_docs, sort_constructors_first
class freelancing {
  final int? id;
  final String text;
  final String Link;
  final String picture;
  final String time;
  final String condition;
  final String sort;
  final String keywords;

  freelancing({
    this.id,
    required this.text,
    required this.Link,
    required this.picture,
    required this.time,
    required this.condition,
    required this.sort,
  required this.keywords,
  });

  factory freelancing.fromMap(Map<String, dynamic> json) => freelancing(
        id: json['id'],
        text: json['text'],
        Link: json['Link'],
        picture: json['picture'],
        time: json['time'],
        condition: json['condition'],
        sort: json['sort'],
  keywords: json['keywords'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'Link': Link,
      'picture': picture,
      'time': time,
      'condition': condition,
      'sort': sort,
      'keywords': keywords,
    };
  }



  factory freelancing.fromJson(Map<String, dynamic> json) {
    return freelancing(
           id: json['id'],
        text: json['text'],
        Link: json['Link'],
        picture: json['picture'],
        time: json['time'],
        condition: json['condition'],
        sort: json['sort'],
      keywords: json['keywords'],
    );
  }


}
