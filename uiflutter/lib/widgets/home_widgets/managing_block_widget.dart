import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uiflutter/extensions/build_context_local.dart';

class ManagingBlockWidget extends StatelessWidget {
  const ManagingBlockWidget({
    super.key,
    required this.isDeviceConnected
  });

  final bool isDeviceConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(context.dimens.paddingLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.dimens.borderRadius),
          color: context.colors.surface,
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
                      backgroundColor: isDeviceConnected
                          ? context.colors.primary
                          : Colors.grey,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: Text(
                      context.strings.start,
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
