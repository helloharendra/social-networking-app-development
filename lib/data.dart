import 'core/net_image.dart';

/// Sample data for the UI demo. The full app uses a scalable feed backend.
class User {
  const User(this.name, this.handle, this.avatar, {this.verified = false});
  final String name, handle, avatar;
  final bool verified;
}

class Post {
  Post({required this.user, required this.image, required this.caption, required this.likes, required this.comments, required this.time, this.location});
  final User user;
  final String image, caption, time;
  final String? location;
  int likes;
  final int comments;
  bool liked = false;
  bool saved = false;
}

final users = <User>[
  User('Aisha Khan', 'aisha.travels', unsplash('1494790108377-be9c29b29330', w: 200), verified: true),
  User('Rohan Mehta', 'rohan.codes', unsplash('1507003211169-0a1dd7228f2d', w: 200)),
  User('Meera Iyer', 'meera.sketches', unsplash('1534528741775-53994a69daeb', w: 200), verified: true),
  User('Kabir Singh', 'kabir.runs', unsplash('1500648767791-00dcc994a43e', w: 200)),
  User('Zara Ali', 'zara.eats', unsplash('1517841905240-472988babdf9', w: 200)),
  User('Dev Patel', 'dev.frames', unsplash('1506794778202-cad84cf45f1d', w: 200), verified: true),
];

final posts = <Post>[
  Post(user: users[0], image: unsplash('1506905925346-21bda4d32df4', w: 1000), caption: 'Above the clouds at sunrise. Worth every step of the 4am hike 🏔️', likes: 2481, comments: 128, time: '2h', location: 'Kedarkantha, Uttarakhand'),
  Post(user: users[5], image: unsplash('1501785888041-af3ef285b470', w: 1000), caption: 'Still waters, loud thoughts.', likes: 1290, comments: 64, time: '5h', location: 'Pangong Lake'),
  Post(user: users[2], image: unsplash('1469474968028-56623f02e42e', w: 1000), caption: 'Golden hour therapy ☀️ Sketch coming soon!', likes: 932, comments: 41, time: '9h'),
  Post(user: users[3], image: unsplash('1476514525535-07fb3b4ae5f1', w: 1000), caption: 'Weekend long run views hit different 🏃‍♂️', likes: 610, comments: 22, time: '1d', location: 'Lake Como'),
];

final explore = [
  '1506905925346-21bda4d32df4', '1501785888041-af3ef285b470', '1469474968028-56623f02e42e', '1476514525535-07fb3b4ae5f1',
  '1500530855697-b586d89ba3ee', '1529626455594-4ff0802cfb7e', '1488426862026-3ee34a7d66df', '1565299624946-b28f40a0ae38',
  '1514432324607-a09d9b4aefdd', '1523275335684-37898b6baf30', '1485955900006-10f4d324d411', '1546069901-ba9599a7e63c',
].map((id) => unsplash(id, w: 500)).toList();
