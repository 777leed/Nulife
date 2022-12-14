import 'package:hive/hive.dart';
import 'package:puzzeled_up/Models/Power/Power.dart';

import '../Models/User/User.dart';

class HiveLab {
  final box = Hive.box('Users');
  final User? currentUser = User.getCurrentUser();
  // add powers to user
  void addPower(Power power) {
    currentUser!.PowerPuffs!.add(power);
    box.put('UserInstance', currentUser);
  }

  int calcPowers() {
    int i = currentUser!.PowerPuffs!.length;
    return i;
  }

  // remove powers from user
  void removePower(Power power) {
    currentUser!.PowerPuffs!.remove(power);
    box.put('UserInstance', currentUser);
  }

  void addXp() {
    currentUser!.setXp(currentUser!.xp! + 1);
    box.put('UserInstance', currentUser);
  }

  //update a power
}
