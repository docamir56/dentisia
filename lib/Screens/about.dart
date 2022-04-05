import 'package:flutter/material.dart';

class About extends StatelessWidget {
  static const route = '/about';
  final String about = '''Dear collegue
      
      
    My believing that one day will be the acadmic learning is free (without courses) and available and enjoyable to everybody,this pushed me to build dentisia (dental social media) which is a container contains dental data in one place and try making dentist's life be more easy and help each other ...


thanks alot to our teacher who teach us without return ,, to my university assuit and specially to my faculty ,, to my collegues and specially my friends ,, special thanks to 3rd and 4rd and 5rd batchs ...'


Special thanks to the great one app developer : Tomas E. Zakaria for helping me and testing the app... 

      
With my greetings ... Intern dentist : A.Y
For contact please kindly send me : dentisia2@gmail.com
      



wait the next update...     ''';

  const About({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: SingleChildScrollView(
            child: Text(
              about,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
