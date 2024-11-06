import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail_page");
      },
      child: const Column(
        children: [
          ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "ID: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'XXXXXXXX',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Course: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'XXXXXXXX',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Billing To: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'XXXXXXXX',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                )
              ],
            ),
            trailing: Text(
              "\$PRICE",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
