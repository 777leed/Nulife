// ignore_for_file: file_names

import 'package:hive/hive.dart';
import '../Power/Power.dart';

part 'User.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(4)
  String name;
  @HiveField(5)
  int? xp;
  @HiveField(6)
  List<Power>? PowerPuffs;

  User(this.name) {
    xp = 0;
    PowerPuffs = [];
  }

//Getters
  getXp() {
    return xp;
  }

  static getCurrentUser() {
    final box = Hive.box('Users');
    User? currentUser = box.get('UserInstance');
    return currentUser;
  }

  getName() {
    return name;
  }

  getAbilities() {
    return PowerPuffs;
  }

  getlevel() {
    return xp! / 100;
  }

// Setters
  setXp(int newXp) {
    xp = newXp;
  }

  setName(String newName) {
    name = newName;
  }

// Adders
  addPower(Power power) {
    PowerPuffs!.add(power);
  }

  deletePower(Power power) {
    PowerPuffs!.remove(power);
  }
}
