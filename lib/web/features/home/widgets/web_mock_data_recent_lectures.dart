import 'package:v2_product_arena/web/features/home/models/lecture.dart';

class UtilsRecent {
  static List<Lecture> getMockedRecentLecture() {
    return [
      Lecture(
          name: '1. Tools: Flutter basics',
          description:
              'In this video you will learn the basics of Figma. A tool with the help of which you will realize your ideas and create prototypes.',
          durationInSeconds: 22232,
          remainingTime: '12:14',
          status: 'Ongoing',
          imageSrc:
              'https://cdn.pixabay.com/photo/2015/09/07/08/22/under-928246_960_720.jpg'),
      Lecture(
          name: '2. Tools: MacBook airmax ',
          description:
              'In this video you will learn the basics of Figma. A tool with the help of which you will realize your ideas and create prototypes.',
          durationInSeconds: 22321,
          remainingTime: '12:14',
          status: 'Ongoing',
          imageSrc:
              'https://cdn.pixabay.com/photo/2015/09/07/08/22/under-928246_960_720.jpg'),
      Lecture(
          name: '3. Tools: PUBG MOBILE',
          description:
              'In this video you will learn the basics of Figma. A tool with the help of which you will realize your ideas and create prototypes.',
          durationInSeconds: 22321,
          remainingTime: '12:14',
          status: 'Ongoing',
          imageSrc:
              'https://cdn.pixabay.com/photo/2015/09/07/08/22/under-928246_960_720.jpg'),
    ];
  }
}
