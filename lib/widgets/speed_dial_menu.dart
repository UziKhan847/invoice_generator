import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialMenu extends StatelessWidget {
  const SpeedDialMenu(
      {super.key,
      required this.indicatorColor,
      required this.navBarColor,
      required this.onTapAddItem,
      required this.onTapLogout,
      required this.onTapSwitchTheme,
      required this.page,
      required this.themeIcon,
      required this.themeLabel});

  final Color? navBarColor;
  final Color? indicatorColor;
  final double page;
  final String themeLabel;
  final IconData themeIcon;
  final VoidCallback onTapAddItem;
  final VoidCallback onTapLogout;
  final VoidCallback onTapSwitchTheme;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.menu,
      activeIcon: Icons.close,
      backgroundColor: navBarColor,
      foregroundColor: Colors.white,
      activeBackgroundColor: indicatorColor,
      activeForegroundColor: Colors.black,
      curve: Curves.fastOutSlowIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.3,
      children: [
        SpeedDialChild(
          onTap: onTapAddItem,
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
          onTap: onTapLogout,
          label: "Logout",
          child: const Icon(Icons.logout),
        )
      ],
    );
  }
}
