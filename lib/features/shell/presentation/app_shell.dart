import 'package:flutter/material.dart';
import 'package:tensio/core/design/tensio_colors.dart';
import 'package:tensio/features/history/presentation/history_screen.dart';
import 'package:tensio/features/home/presentation/home_screen.dart';
import 'package:tensio/features/insights/presentation/insights_screen.dart';
import 'package:tensio/features/measurement/presentation/new_measurement_screen.dart';
import 'package:tensio/features/settings/presentation/profile_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;
  static const pages = <Widget>[HomeScreen(), HistoryScreen(), SizedBox.shrink(), InsightsScreen(), ProfileScreen()];

  Future<void> _openMeasurement() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(fullscreenDialog: true, builder: (_) => const NewMeasurementScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TensioColors.coral,
        foregroundColor: TensioColors.background,
        onPressed: _openMeasurement,
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          if (value == 2) { _openMeasurement(); return; }
          setState(() => index = value);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Ana Sayfa'),
          NavigationDestination(icon: Icon(Icons.history_rounded), label: 'Geçmiş'),
          NavigationDestination(icon: SizedBox(width: 34, height: 24), label: ''),
          NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights_rounded), label: 'Analiz'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}
