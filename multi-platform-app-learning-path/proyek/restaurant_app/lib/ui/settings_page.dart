import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Pengaturan';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          settingsTitle,
        ),
        foregroundColor: Colors.white,
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, pref, child) => ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Tema Gelap'),
              trailing: Switch.adaptive(
                value: pref.isDarkTheme,
                onChanged: (value) {
                  pref.enableDarkTheme(value);
                },
              ),
            ),
          ),
          Material(
            child: ListTile(
              title: const Text('Notifikasi Restoran'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: pref.isDailyRestaurantActive,
                    onChanged: (value) async {
                      scheduled.scheduledRestaurant(value);
                      pref.enableDailyRestaurant(value);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
