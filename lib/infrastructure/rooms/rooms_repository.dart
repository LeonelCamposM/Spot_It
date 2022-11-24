import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/i_room_repository.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/infrastructure/rooms/eventListeners/on_joinable_update.dart';

class RoomRepository implements IRoomRepository {
  final CollectionReference<Room> _roomsCollection;

  RoomRepository(FirebaseFirestore firestore)
      : _roomsCollection = firestore.collection('Room').withConverter<Room>(
              fromFirestore: (doc, options) => Room.fromJson(doc.data()!),
              toFirestore: (employee, options) => employee.toJson(),
            );

  @override
  Future<String> createRoom(Room room) async {
    final reference = await _roomsCollection.add(room);
    return reference.id;
  }

  @override
  Future<void> updateJoinable(String roomID) async {
    DocumentSnapshot roomDoc = await _roomsCollection.doc(roomID).get();
    Room roomInstance = roomDoc.data() as Room;
    await _roomsCollection.doc(roomID).update(
        Room(0, false, false, true, false, false, roomInstance.maximumRounds)
            .toJson());
  }

  @override
  Future<int> getMaximumRoundCount(String roomID) async {
    DocumentSnapshot roomDoc = await _roomsCollection.doc(roomID).get();
    Room roomInstance = roomDoc.data() as Room;
    return roomInstance.maximumRounds;
  }

  @override
  Future<void> updateMaximumRound(String roomID, int maximumCount) async {
    DocumentSnapshot roomDoc = await _roomsCollection.doc(roomID).get();
    Room roomInstance = roomDoc.data() as Room;
    await _roomsCollection.doc(roomID).update(Room(
            roomInstance.round,
            roomInstance.joinable,
            roomInstance.dealedCards,
            roomInstance.newRound,
            roomInstance.finished,
            roomInstance.updatedRound,
            maximumCount)
        .toJson());
  }

  // @override
  // Widget onJoinableUpdate(
  //     String roomID, String icon, String playerNickName, bool isHost, ) {
  //   return OnJoinableUpdate(
  //     roomID: roomID,
  //     icon: icon,
  //     playerNickName: playerNickName,
  //     isHost: isHost,
  //   );
  // }
}
