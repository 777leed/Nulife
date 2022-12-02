// ignore_for_file: file_names
import 'package:hive/hive.dart';

part 'Power.g.dart';

@HiveType(typeId: 0)
class Power extends HiveObject {
  @HiveField(0)
  final String power_name;
  @HiveField(1)
  final int streak;
  @HiveField(2)
  final String description;
  Power(this.power_name, this.description, this.streak);
}
