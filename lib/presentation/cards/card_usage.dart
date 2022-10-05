import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/domain/cards/card_data.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';

class CardUsage extends StatefulWidget {
  static String routeName = '/card_usage';
  const CardUsage({Key? key}) : super(key: key);

  @override
  State<CardUsage> createState() => _CardUsageState();
}

class _CardUsageState extends State<CardUsage> {
  _CardUsageState() : isLoading = true;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    addRoom();
  }

  Future<void> addRoom() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Guia cartas'),
          backgroundColor: const Color.fromARGB(255, 60, 60, 60)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading ? const LoadingWidget() : const _RoomWidget(),
        ),
      ),
    );
  }
}

class _RoomWidget extends StatefulWidget {
  const _RoomWidget({Key? key}) : super(key: key);

  @override
  State<_RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<_RoomWidget> {
  static const List<String> icons = [
    "Anchor",
    "Apple",
    "Bomb",
    "Cactus",
    "Candle",
    "Carrot",
    "Cheese",
    "Chess knight"
  ];

  // static final jsonCard = {
  //   'icons':
  //       '[Anchor, Apple, Bomb, Cactus, Candle, Carrot, Cheese, Chess knight]'
  // };
  // static CardData card = CardData.fromJson(jsonCard);

  // card that will be displayed
  static CardData card = CardData(icons);

  Map<String, dynamic> json = card.toJson();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(json.toString()),
              // renderig card
              getCardStyle(card, 300),
              getCardStyle(card, 200),
              getCardStyle(card, 100),
              getCardStyle(card, 200),
              getCardStyle(card, 200),
              getCardStyle(card, 200),
            ],
          ),
        ),
      ],
    );
  }
}
