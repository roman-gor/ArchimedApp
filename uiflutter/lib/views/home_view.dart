import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                      onPressed: () {})
                ],
              ),
            )
          )
        ],
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
                width: 140,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    "Start",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
