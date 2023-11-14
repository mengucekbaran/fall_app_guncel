import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 24,
          backgroundColor: Color.fromARGB(255, 247, 247, 197),
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: '\t\t\t\t\t\t\t\t\t\t\tKahvenin ',
            style: TextStyle(
              color: Colors.orange,
              fontFamily: 'AlfaSlabOne',
            ),
          ),
          TextSpan(
            text: 'lezzeti,\n ',
            style: TextStyle(
              color: Colors.pink,
              fontFamily: 'Cormorant',
            ),
          ),
          TextSpan(
            text: '\t\t\t\tElin ',
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'AlfaSlabOne',
            ),
          ),
          TextSpan(
            text: 'dokunuşu, ',
            style: TextStyle(
              color: Colors.blue,
              fontFamily: 'Cormorant',
            ),
          ),
          TextSpan(
            text: 'Yüzün ',
            style: TextStyle(
              color: Colors.indigo,
              fontFamily: 'AlfaSlabOne',
            ),
          ),
          TextSpan(
            text: 'sırrı... ',
            style: TextStyle(
              color: Colors.purple,
              fontFamily: 'Cormorant',
            ),
          ),
          TextSpan(
            text: 'Geçmişin, ',
            style: TextStyle(
              color: Colors.pink,
              fontFamily: 'BrunoAceSC',
            ),
          ),
          TextSpan(
            text: 'bugünün ',
            style: TextStyle(
              color: Colors.cyan,
              fontFamily: 'BrunoAceSC',
            ),
          ),
          TextSpan(
            text: '\nve ',
            style: TextStyle(
              color: Colors.teal,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
          TextSpan(
            text: 'geleceğin ',
            style: TextStyle(
              color: Colors.deepOrange,
              fontFamily: 'BrunoAceSC',
            ),
          ),
          TextSpan(
            text: 'bir araya ',
            style: TextStyle(
              color: Colors.teal,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
          TextSpan(
            text: 'geldiği ',
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'GreatVibes',
            ),
          ),
          TextSpan(
            text: 'fal dünyasına ',
            style: TextStyle(
              color: Colors.amber,
              fontFamily: 'BrunoAceSC',
            ),
          ),
          TextSpan(
            text: '\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\thoş geldin!',
            style: TextStyle(
              color: Colors.pink,
              fontFamily: 'BrunoAceSC',
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
