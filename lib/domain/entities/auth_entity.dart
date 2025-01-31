import 'package:hive/hive.dart';
part 'auth_entity.g.dart';

@HiveType(typeId: 0)
class AuthenticationEntity {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String? phone;
  @HiveField(4)
  final String? photo;

  const AuthenticationEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    this.photo,
  });
}
