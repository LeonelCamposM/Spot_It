import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game_root/game_root.dart';

// ignore: must_be_immutable
class OnJoinableUpdate extends StatelessWidget {
  String roomID;
  String icon;
  String playerNickName;
  late Stream<QuerySnapshot> _usersStream;
  bool isHost;
  Function setParentState;

  OnJoinableUpdate(
      {Key? key,
      required this.roomID,
      required this.icon,
      required this.playerNickName,
      required this.isHost,
      required this.setParentState})
      : super(key: key) {
    _usersStream = FirebaseFirestore.instance.collection('Room').snapshots();
  }
  final List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: SizeConfig.blockSizeVertical * 85,
              width: SizeConfig.blockSizeHorizontal * 50,
              child: const Text(''));
        }

        Room room = getUpdateRoom(snapshot, roomID);
        if (room.joinable == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            setParentState(NavigationState.game, null);
          });
          return const Text('');
        } else {
          return getText("Esperando al host para comenzar ...",
              SizeConfig.safeBlockHorizontal * 1.5, Alignment.topCenter);
        }
      },
    );
  }
}

// @param snapshot: enventListener on database
// @return roomID data
Room getUpdateRoom(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, roomID) {
  // Get updated room from snapshot
  List<Room> messages = [];
  ListView(
    children: snapshot.data!.docs
        .map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          if (document.id == roomID) {
            messages.add(Room.fromJson(data));
          }
        })
        .toList()
        .cast(),
  );

  return messages.first;
}
