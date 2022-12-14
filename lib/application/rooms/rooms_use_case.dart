import 'package:spot_it_game/domain/rooms/i_room_repository.dart';
import 'package:spot_it_game/domain/rooms/room.dart';

class RoomUseCase {
  final IRoomRepository roomRepository;

  RoomUseCase(this.roomRepository);

  Future<String> createRoom(Room room) async {
    return roomRepository.createRoom(room);
  }

  // Widget onJoinableUpdate(
  //     String roomID, String icon, String playerNickName, bool isHost) {
  //   return roomRepository.onJoinableUpdate(
  //       roomID, icon, playerNickName, isHost);
  // }

  Future<void> updateJoinable(roomID) async {
    return roomRepository.updateJoinable(roomID);
  }

  Future<int> getMaximumRoundCount(roomID) async {
    return roomRepository.getMaximumRoundCount(roomID);
  }

  Future<void> updateMaximumRound(roomID, maximumCount) async {
    return roomRepository.updateMaximumRound(roomID, maximumCount);
  }

  Future<bool> validateNumberOfPlayers(roomID) async {
    return roomRepository.validateNumberOfPlayers(roomID);
  }
}
