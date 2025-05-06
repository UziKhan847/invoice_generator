import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialMenu extends StatelessWidget {
  SpeedDialMenu({
    super.key,
    required this.indicatorColor,
    required this.navBarColor,
    required this.textColor,
    required this.activeTextColor,
    required this.onTapAddItem,
    required this.onTapLogout,
    required this.onTapSwitchTheme,
    required this.onTapUploadLogo,
    required this.page,
    required this.themeIcon,
    required this.themeLabel,
  });

  final Color? navBarColor;
  final Color? indicatorColor;
  final Color? textColor;
  final Color? activeTextColor;
  final double page;
  final String themeLabel;
  final IconData themeIcon;
  final VoidCallback onTapAddItem;
  final VoidCallback onTapLogout;
  final VoidCallback onTapSwitchTheme;
  final VoidCallback onTapUploadLogo;

  final ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.menu,
      activeIcon: Icons.close,
      backgroundColor: navBarColor,
      foregroundColor: textColor,
      activeBackgroundColor: indicatorColor,
      activeForegroundColor: activeTextColor,
      curve: Curves.fastOutSlowIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      closeManually: true,
      openCloseDial: isDialOpen,
      children: [
        SpeedDialChild(
          onTap: () {
            onTapAddItem();
            isDialOpen.value = false;
          },
          label: "Add ${switch (page) {
            1 => 'Sender',
            2 => 'Recipient',
            3 => 'Course',
            4 => 'Receipt',
            _ => 'Invoice',
          }}",
          child: const Icon(Icons.add),
        ),
        SpeedDialChild(
          onTap: onTapSwitchTheme,
          label: '$themeLabel Mode',
          child: Icon(
            themeIcon,
          ),
        ),
        SpeedDialChild(
          onTap: onTapUploadLogo,
          label: "Upload Logo",
          child: const Icon(Icons.image),
        ),
        SpeedDialChild(
          onTap: onTapLogout,
          label: "Logout",
          child: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
