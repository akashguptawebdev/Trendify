import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
// Ensure this is imported

Widget myButton({ onPress, required Color color, required Color textColor, required String title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,  // Call the onPress callback correctly
    child: title.text.color(textColor).make(),  // Ensure title is treated as a string and styled with VelocityX

  );
}
