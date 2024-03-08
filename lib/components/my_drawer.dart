import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const DrawerHeader(
              child: Center(
            child: Icon(Icons.music_note),
          )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('DARK MODE'),
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
