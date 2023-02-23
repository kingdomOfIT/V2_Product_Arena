class Lecture {
  String name;
  String description;
  int durationInSeconds;
  String remainingTime;
  String status;
  String imageSrc;

  Lecture(
      {required this.name,
      required this.description,
      required this.durationInSeconds,
      required this.remainingTime,
      required this.status,
      required this.imageSrc});
}

class UserLecture {
  //String id;
  String? name;
  String? description;
  int? durationInSeconds;
  //String remainingTime;
  //String status;
  String? imageSrc;
  String? contentLink;
  int? lastStoppedInSeconds;

  UserLecture({
    // required this.id,
    required this.name,
    required this.description,
    required this.durationInSeconds,
    //required this.remainingTime,
    //required this.status,
    required this.imageSrc,
    required this.contentLink,
    required this.lastStoppedInSeconds,
  });
  UserLecture.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    description = map['description'];
    durationInSeconds = map['durationInSeconds'];
    imageSrc = map['imageSrc'];
    contentLink = map['contentLink'];
    lastStoppedInSeconds = map['lastStoppedInSeconds'];
  }
}
