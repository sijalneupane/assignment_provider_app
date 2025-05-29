import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/home/provider/theme_provider.dart';

class ChangeThemePoc extends StatefulWidget {
  const ChangeThemePoc({super.key});

  @override
  State<ChangeThemePoc> createState() => _ChangeThemePocState();
}

class _ChangeThemePocState extends State<ChangeThemePoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Mode with Provider'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return PopupMenuButton<ThemeMode>(
                onSelected: (ThemeMode mode) {
                  themeProvider.setThemeMode(mode);
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: ThemeMode.system,
                    child: Row(
                      children: [
                        Icon(Icons.brightness_auto),
                        SizedBox(width: 8),
                        Text('System'),
                        if (themeProvider.themeMode == ThemeMode.system)
                          Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.light,
                    child: Row(
                      children: [
                        Icon(Icons.brightness_high),
                        SizedBox(width: 8),
                        Text('Light'),
                        if (themeProvider.themeMode == ThemeMode.light)
                          Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Row(
                      children: [
                        Icon(Icons.brightness_2),
                        SizedBox(width: 8),
                        Text('Dark'),
                        if (themeProvider.themeMode == ThemeMode.dark)
                          Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Theme Mode:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 16),
                Text(
                  themeProvider.themeMode.toString().split('.').last.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => themeProvider.setThemeMode(ThemeMode.light),
                  icon: Icon(Icons.brightness_high),
                  label: Text('Light Mode'),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => themeProvider.setThemeMode(ThemeMode.dark),
                  icon: Icon(Icons.brightness_2),
                  label: Text('Dark Mode'),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => themeProvider.setThemeMode(ThemeMode.system),
                  icon: Icon(Icons.brightness_auto),
                  label: Text('System Mode'),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => themeProvider.toggleTheme(),
                  icon: Icon(Icons.swap_horiz),
                  label: Text('Toggle Theme'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
