import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/invoice_list_page");
      },
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.account_box,
              size: 30,
            ),
            title: Text(name, textAlign: TextAlign.center),
            trailing: const Icon(Icons.arrow_right),
          ),
          const Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
