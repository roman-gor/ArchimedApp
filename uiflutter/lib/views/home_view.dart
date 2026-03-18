import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uiflutter/l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  static const EventChannel _eventChannel = EventChannel('com.gorman.archimed/events');

  Stream<String>? _bluetoothDataState;

  Future<void> _checkPermissions() async {
    print("DEBUG: Запрос разрешений начался...");
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    if (statuses[Permission.bluetoothScan]!.isDenied) {
      print("Пользователь отклонил разрешение на сканирование");
    }
  }

  @override
  void initState() {
    super.initState();
    _bluetoothDataState = _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event as String);
  }


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundImage = isDark
        ? 'assets/images/bg_dark.png'
        : 'assets/images/bg_light.png';

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            bottom: false,
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  top: 22
              ),
              child: Column(
                spacing: 8,
                children: [
                  _blockDeviceStatusInformation(context),
                  Expanded(
                    child: Row(
                      spacing: 8,
                      children: [
                        _blockTools(context),
                        Expanded(child: _blockManaging(context))
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
        )
    );
  }

  Widget _blockDeviceStatusInformation(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.0),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 1),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 28,
                  ),
                  Text(
                    "Biology",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  _iconTransparentButton(
                      color: Theme.of(context).colorScheme.onSurface,
                      icon: Icons.format_list_bulleted_rounded,
                      onPressed: () {
                        getStream();
                      })
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  void getStream() {
    _checkPermissions();
    _bluetoothDataState?.listen((data) {
      print("Пришли данные: $data");
    });

    showDevicesSelectedDialog(context);
  }

  void showDevicesSelectedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: 400,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Доступные устройства',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 1000,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text('Устройство $index'),
                          onTap: () {
                            print('Выбрано устройство $index');
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                        width: 120,
                        height: 40,
                        child: _uncoloredButton(
                            context: context,
                            text: AppLocalizations.of(context)!.close
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _uncoloredButton({required BuildContext context, required String text}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withAlpha(70),
          width: 1.0,
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onTertiary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _blockTools(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          spacing: 0,
          children: [
            _iconTransparentButton(
                color: Theme.of(context).colorScheme.onSurface,
                icon: Icons.format_list_bulleted_rounded,
                onPressed: () {}),
            _iconTransparentButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.local_drink_rounded,
                onPressed: () {}),
            _iconTransparentButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.book_rounded,
                onPressed: () {}),
            _iconTransparentButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.list_alt_outlined,
                onPressed: () {}),
            Expanded(child: SizedBox()),
            _iconTransparentButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.settings_rounded,
                onPressed: () {})
          ],
        )
    );
  }

  Widget _iconTransparentButton({Color? color, IconData? icon, Function()? onPressed}) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(icon),
      color: color,
      iconSize: 26,
      onPressed: onPressed,
    );
  }

  Widget _blockManaging(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/images/main_image.svg'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 90,
                height: 42,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            )
          ],
        )
    );
  }
}
