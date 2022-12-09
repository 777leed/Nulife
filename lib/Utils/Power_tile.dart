import 'package:flutter/material.dart';

class PowerTile extends StatelessWidget {
  final String powerName;
  final String powerLevel;
  final powerColor;
  final String imageName;
  final VoidCallback? onHold;

  final double borderRadius = 12;

  const PowerTile({
    super.key,
    required this.powerName,
    required this.powerLevel,
    required this.powerColor,
    required this.imageName,
    this.onHold,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero, // Set this
        padding: EdgeInsets.zero, // and this
      ),
      onLongPress: onHold,
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          color: powerColor[50],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: powerColor[100],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'lvl $powerLevel',
                    style: TextStyle(
                      color: powerColor[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),

            // donut picture
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12),
              child: Image.asset(imageName),
            ),

            // donut flavor
            Text(
              powerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            // power on icon
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // love icon
                  Icon(
                    Icons.power_settings_new,
                    color: Colors.pink[400],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
