import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/cards/card_usage.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:spot_it_game/presentation/scoreboard/colors.dart';

class ScoreboardPage extends StatefulWidget {
  static String routeName = '/scoreboard'; // /scoreboard
  const ScoreboardPage({Key? key}) : super(key: key);
  @override
  State<ScoreboardPage> createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  _ScoreboardPageState() : isLoading = true;

  bool isLoading;
  List<IconData> icons = [
    Icons.panorama_vertical,
    Icons.leaderboard,
    Icons.panorama_vertical_select,
  ];
  List<String> names = ["Sofia", "Nayeri", "Jeremy"];
  String roomID = "Tabla de posiciones";

  @override
  void initState() {
    super.initState();
    addRoom();
  }

  Future<void> addRoom() async {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      appBar: AppBar(
        title: const Text('Resultados'),
        automaticallyImplyLeading: false,
        backgroundColor: getSecondaryColor(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getIconButtonStyle(
                    getSecondaryColor(),
                    IconButton(
                      iconSize: getIconSize(),
                      icon: const Icon(Icons.home),
                      color: getFontColor(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                  ),
                  getIconButtonStyle(
                    getSecondaryColor(),
                    IconButton(
                      iconSize: getIconSize(),
                      icon: const Icon(Icons.replay),
                      color: getFontColor(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            getFocusBox(
              Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getIconButtonStyle(
                          getSecondaryColor(),
                          IconButton(
                            iconSize: getIconSize(),
                            icon: const Icon(Icons.list),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            },
                          ),
                        ),
                        Text(roomID,
                            style: const TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center),
                        const Text("", style: TextStyle(fontSize: 20.0)),
                      ],
                    ),
                  ),
                  const Text("", style: TextStyle(fontSize: 40.0)),
                  Flexible(
                    flex: 4,
                    child: SizedBox(
                        height: 300,
                        width: 850,
                        child: _horizontalList(3, names, icons)),
                  ),
                ],
              ),
              500,
              900,
            )
          ],
        ),
      ),
    );
  }
}

Container _horizontalList(int n, List<String> names, List<IconData> icons) {
  return Container(
    alignment: Alignment.center,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        n,
        (i) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 400,
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      shape: BoxShape.circle),
                  child: Icon(
                    icons[i],
                    size: 100,
                  )),
              const Text("", style: TextStyle(fontSize: 40.0)),
              Text(names[i], style: const TextStyle(fontSize: 20.0))
            ]),
          ),
        ),
      ),
    ),
  );
}
