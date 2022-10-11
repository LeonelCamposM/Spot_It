import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/clients/client_service.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/create_room/create_room.dart';
import 'package:spot_it_game/presentation/home/colors.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _RoomPageState();
}

class _RoomPageState extends State<HomePage> {
  _RoomPageState() : isLoading = true;
  // TODO final _roomUseCase = RoomUseCase(RoomRepository(FirebaseFirestore.instance));
  bool isLoading;

  @override
  void initState() {
    super.initState();
    addRoom();
  }

  Future<void> addRoom() async {
    // TODO move
    // Room newRoom = Room("leonel", true);
    // await _roomUseCase.createRoom(newRoom);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      appBar: AppBar(
          title: const Text('Inicio'),
          automaticallyImplyLeading: false,
          backgroundColor: getSecondaryColor()),
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
  final ClientService clientService = ClientService();
  final ButtonStyle style =
      getButtonStyle(650, 85, 30.0, const Color.fromARGB(255, 06, 70, 99));

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        getFocusBox(
            Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Flexible(
                        flex: 3,
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: getText("Spot it!",SizeConfig.blockSizeHorizontal * 3, Alignment.center),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getTextButton(
                          "ANFITRIÓN",
                          SizeConfig.safeBlockHorizontal * 30,
                          SizeConfig.safeBlockVertical * 12,
                          SizeConfig.safeBlockHorizontal * 2,
                          getSecondaryColor(),
                          const HostCreateRoomPage(),
                          context
                      ),
                      getTextButton(
                          "INVITADO",
                          SizeConfig.safeBlockHorizontal * 30,
                          SizeConfig.safeBlockVertical * 12,
                          SizeConfig.safeBlockHorizontal * 2,
                          getSecondaryColor(),
                          const HostCreateRoomPage(),
                          context
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizeConfig.safeBlockVertical * 80,
            SizeConfig.safeBlockHorizontal * 50
          ),
        Flexible(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getChildrenWithIcon(
                  context,
                  const Icon(Icons.question_mark_rounded),
                  getSecondaryColor(),
                  MaterialPageRoute(builder: (context) => const HomePage()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
