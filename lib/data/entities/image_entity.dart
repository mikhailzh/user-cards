import 'package:objectbox/objectbox.dart';
import 'package:user_cards/domain/models/hobby.dart';
import 'package:user_cards/domain/models/language.dart';
import 'package:user_cards/domain/models/location.dart';
import 'package:user_cards/domain/models/user_goal.dart';
import 'package:user_cards/domain/models/verdict.dart';

@Entity()
class ImageEntity {
  int id;
  int userId;
  String href;

  ImageEntity({
    required this.id,
    required this.href,
    required this.userId,
  });
}