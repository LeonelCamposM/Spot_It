import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/players/i_player_repository.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';
import 'package:spot_it_game/infrastructure/players/eventListeners/on_players_update.dart';

class PlayerRepository implements IPlayerRepository {
  final CollectionReference<Player> _playersCollection;

  PlayerRepository(FirebaseFirestore firestore)
      : _playersCollection =
            firestore.collection('Room_Player').withConverter<Player>(
                  fromFirestore: (doc, options) => Player.fromJson(doc.data()!),
                  toFirestore: (employee, options) => employee.toJson(),
                );

  @override
  Future<String> addPlayer(Player player, String roomID) async {
    final reference = _playersCollection.doc(roomID).collection("players");
    final newPlayer = await reference.add(player.toJson());
    return newPlayer.id;
  }

  @override
  Widget onPlayersUpdate(String roomID) {
    return OnPlayersUpdate(roomID: roomID);
  }

  @override
  Future<bool> spotIt(
      String roomID, String playerOneNickname, String playerTwoNickname) async {
   
    final db = FirebaseFirestore.instance;
    var playersReference =
        db.collection('Room_Player').doc(roomID).collection('players');
    var scoreboardReference = db
        .collection('Room_Scoreboard')
        .doc('jTKFlTMyk0Rw24pdPcmv')
        .collection('Scoreboard');

    Player playerUpdated = Player("", "", "", 0, 0);
    Scoreboard scoreboardUpdated = Scoreboard("", 0);

    var players = await playersReference.get();
    var scoreboard = await scoreboardReference.get();

    var winnerPlayerData = players.docs
        .where((element) => element.data()['nickname'] == playerOneNickname)
        .first;
    var scoreboardWinnerData = scoreboard.docs
        .where((element) => element.data()['nickname'] == playerOneNickname)
        .first;

    var loserPlayerData = players.docs
        .where((element) => element.data()['nickname'] == playerTwoNickname)
        .first;

    Player winnerPlayer = Player(winnerPlayerData['nickname'], winnerPlayerData["icon"],
            winnerPlayerData["displayedCard"], winnerPlayerData["cardCount"], winnerPlayerData["stackCardsCount"]);

    //Updated winner player and score for winner
    playerUpdated = Player(
       winnerPlayer.nickname,
        winnerPlayer.icon,
        "QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark",
        0,
        0);
    await winnerPlayerData.reference.update(playerUpdated.toJson());

    scoreboardUpdated = Scoreboard(scoreboardWinnerData.data()['nickname'],
        scoreboardWinnerData.data()['score'] + 1);
    await scoreboardWinnerData.reference.update(scoreboardUpdated.toJson());

    //Updated loser player 
    playerUpdated = Player(
        loserPlayerData.data()['nickname'],
        loserPlayerData.data()['icon'],
        winnerPlayer.displayedCard,
        loserPlayerData.data()['cardCount'] + winnerPlayer.cardCount,
        loserPlayerData.data()['cardCount'] + winnerPlayer.stackCardsCount);

    await loserPlayerData.reference.update(playerUpdated.toJson());

    return false;
  }

  Future<List<Player>> getPlayers(String roomID) async {
    final collection =
        await _playersCollection.doc(roomID).collection("players").get();
    List<Player> result = [];
    collection.docs
        .map((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          result.add(Player(
              data['nickname'],
              data['icon'],
              data['displayedCard'],
              data['cardCount'],
              data['stackCardsCount']));
        })
        .toList()
        .cast();
    return result;
  }
}
