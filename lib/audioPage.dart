import 'package:flutter/material.dart';
import 'appcolors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audioFile.dart';

class DetailAudioPage extends StatefulWidget {
  @override
  _DetailAudioPageState createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFfafafc),
      body: Stack(
        children: [
          // Background container
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              color: Color(0xff1791f4),
            ),
          ),
          // SafeArea to avoid the system status bar overlap
          SafeArea(
            child: Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors
                        .white, // Ensure the icon is visible on blue background
                  ),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {})
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.3,
            height: screenHeight * 0.36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    "THE WATER CURE",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir"),
                  ),
                  Text(
                    "Martin Hyatt",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  AudioFile(advancedPlayer: advancedPlayer),
                ],
              ),
            ),
          ),
          Positioned(
              top: screenHeight * 0.16,
              left: (screenWidth - 150) / 2,
              right: (screenWidth - 150) / 2,
              height: screenHeight * 0.24,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFf2f2f2),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                      image: DecorationImage(
                        image: AssetImage("assets/pic-1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
