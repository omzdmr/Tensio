import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TensioApp());
}

abstract final class TColors {
  static const midnight = Color(0xFF071119);
  static const midnightSoft = Color(0xFF0B1721);
  static const slate = Color(0xFF12212D);
  static const raised = Color(0xFF182A38);
  static const ink = Color(0xFFF4F7FA);
  static const muted = Color(0xFF92A4B3);
  static const coral = Color(0xFFFF5C7A);
  static const coralSoft = Color(0xFFFF8DA2);
  static const mint = Color(0xFF42DA9A);
  static const sky = Color(0xFF65B9FF);
  static const amber = Color(0xFFFFC65A);
  static const violet = Color(0xFF9587FF);
}

class PressureReading {
  const PressureReading({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.takenAt,
    this.context,
    this.note,
  });

  final int systolic;
  final int diastolic;
  final int pulse;
  final DateTime takenAt;
  final String? context;
  final String? note;

  String get display => '$systolic / $diastolic';
}

class ReadingStore extends ChangeNotifier {
  ReadingStore(this._readings);

  factory ReadingStore.seeded() {
    final now = DateTime.now();
    return ReadingStore([
      PressureReading(
        systolic: 120,
        diastolic: 80,
        pulse: 72,
        takenAt: now.subtract(const Duration(hours: 2)),
        context: 'Sabah',
      ),
      PressureReading(
        systolic: 125,
        diastolic: 82,
        pulse: 74,
        takenAt: now.subtract(const Duration(days: 1, hours: 3)),
        context: 'Akşam',
      ),
      PressureReading(
        systolic: 118,
        diastolic: 76,
        pulse: 70,
        takenAt: now.subtract(const Duration(days: 2, hours: 1)),
        context: 'Sabah',
      ),
      PressureReading(
        systolic: 132,
        diastolic: 84,
        pulse: 77,
        takenAt: now.subtract(const Duration(days: 3, hours: 4)),
        context: 'Akşam',
      ),
      PressureReading(
        systolic: 121,
        diastolic: 79,
        pulse: 71,
        takenAt: now.subtract(const Duration(days: 4, hours: 2)),
        context: 'Sabah',
      ),
    ]);
  }

  final List<PressureReading> _readings;

  List<PressureReading> get readings =>
      List<PressureReading>.unmodifiable(_readings);

  PressureReading? get latest => _readings.isEmpty ? null : _readings.first;

  void add(PressureReading reading) {
    _readings.insert(0, reading);
    _readings.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    notifyListeners();
  }

  double get averageSystolic => _average((r) => r.systolic);
  double get averageDiastolic => _average((r) => r.diastolic);
  double get averagePulse => _average((r) => r.pulse);

  double _average(int Function(PressureReading reading) selector) {
    if (_readings.isEmpty) return 0;
    final total = _readings.fold<int>(
      0,
      (sum, reading) => sum + selector(reading),
    );
    return total / _readings.length;
  }
}

class TensioApp extends StatefulWidget {
  const TensioApp({super.key});

  @override
  State<TensioApp> createState() => _TensioAppState();
}

class _TensioAppState extends State<TensioApp> {
  final ReadingStore store = ReadingStore.seeded();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tensio',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.dark,
      home: TensioShell(store: store),
    );
  }

  ThemeData _darkTheme() {
    final scheme = ColorScheme.fromSeed(
      seedColor: TColors.coral,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: TColors.midnight,
      colorScheme: scheme.copyWith(
        primary: TColors.coral,
        secondary: TColors.mint,
        surface: TColors.midnightSoft,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 27,
          height: 1.1,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.7,
          color: TColors.ink,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: TColors.ink,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: TColors.ink,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.45,
          color: TColors.ink,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.4,
          color: TColors.muted,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TColors.slate,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withAlpha(14)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: TColors.coral, width: 1.4),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: TColors.coral,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: TColors.midnightSoft,
        elevation: 12,
      ),
    );
  }

  ThemeData _lightTheme() {
    final scheme = ColorScheme.fromSeed(
      seedColor: TColors.coral,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.copyWith(primary: TColors.coral),
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    );
  }
}

class TensioShell extends StatefulWidget {
  const TensioShell({super.key, required this.store});

  final ReadingStore store;

  @override
  State<TensioShell> createState() => _TensioShellState();
}

class _TensioShellState extends State<TensioShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(store: widget.store, onAdd: _openMeasurement),
      HistoryScreen(store: widget.store),
      InsightsScreen(store: widget.store),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: index, children: pages),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'new-reading',
        onPressed: _openMeasurement,
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 78,
        notchMargin: 9,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            Expanded(
              child: _NavButton(
                icon: Icons.home_rounded,
                label: 'Ana Sayfa',
                selected: index == 0,
                onTap: () => setState(() => index = 0),
              ),
            ),
            Expanded(
              child: _NavButton(
                icon: Icons.history_rounded,
                label: 'Geçmiş',
                selected: index == 1,
                onTap: () => setState(() => index = 1),
              ),
            ),
            const SizedBox(width: 64),
            Expanded(
              child: _NavButton(
                icon: Icons.insights_rounded,
                label: 'Analiz',
                selected: index == 2,
                onTap: () => setState(() => index = 2),
              ),
            ),
            Expanded(
              child: _NavButton(
                icon: Icons.person_rounded,
                label: 'Profil',
                selected: index == 3,
                onTap: () => setState(() => index = 3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openMeasurement() async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MeasurementSheet(store: widget.store),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? TColors.coral : TColors.muted;

    return InkResponse(
      onTap: onTap,
      radius: 30,
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.store,
    required this.onAdd,
  });

  final ReadingStore store;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final latest = store.latest;

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 124),
          children: [
            const _Header(),
            const SizedBox(height: 24),
            if (latest != null)
              PremiumCard(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF103E32),
                    Color(0xFF0A281F),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Son ölçüm',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.favorite_rounded,
                          color: TColors.mint,
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          latest.display,
                          style: const TextStyle(
                            fontSize: 44,
                            height: 1,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'mmHg',
                            style: TextStyle(color: TColors.muted),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Pill(
                          icon: Icons.monitor_heart_outlined,
                          label: '${latest.pulse} bpm',
                        ),
                        if (latest.context != null)
                          _Pill(
                            icon: Icons.schedule_rounded,
                            label: latest.context!,
                          ),
                        const _Pill(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'Takip kaydı',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: QuickAction(
                    icon: Icons.add_rounded,
                    label: 'Yeni ölçüm',
                    accent: TColors.coral,
                    onTap: onAdd,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: QuickAction(
                    icon: Icons.description_outlined,
                    label: 'Rapor',
                    accent: TColors.sky,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: QuickAction(
                    icon: Icons.notifications_none_rounded,
                    label: 'Hatırlatıcı',
                    accent: TColors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Text(
                  '7 günlük görünüm',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(
                  '${store.readings.length} kayıt',
                  style: const TextStyle(color: TColors.muted),
                ),
              ],
            ),
            const SizedBox(height: 12),
            PremiumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      _Legend(color: TColors.coral, label: 'Sistolik'),
                      SizedBox(width: 16),
                      _Legend(color: TColors.sky, label: 'Diyastolik'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TrendChart(readings: store.readings),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Text('Bugün', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(
                  child: MetricCard(
                    icon: Icons.favorite_border_rounded,
                    label: 'Nabız',
                    value: '72',
                    unit: 'bpm',
                    accent: TColors.coralSoft,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MetricCard(
                    icon: Icons.water_drop_outlined,
                    label: 'Su',
                    value: '1.6',
                    unit: 'L',
                    accent: TColors.sky,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const PremiumCard(
              child: Row(
                children: [
                  _IconTile(
                    icon: Icons.medication_outlined,
                    accent: TColors.violet,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'İlaç takibi',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Hatırlatıcı ve kullanım geçmişi tek yerde.',
                          style: TextStyle(color: TColors.muted),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Merhaba', style: TextStyle(color: TColors.muted)),
              const SizedBox(height: 3),
              Text('Tensio', style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: TColors.slate,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withAlpha(18)),
          ),
          child: const Icon(Icons.person_rounded),
        ),
      ],
    );
  }
}

class PremiumCard extends StatelessWidget {
  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.gradient,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? TColors.slate : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withAlpha(14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(32),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return box;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: box,
    );
  }
}

class QuickAction extends StatelessWidget {
  const QuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.accent,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Column(
        children: [
          Icon(icon, color: accent, size: 27),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent),
          const SizedBox(height: 18),
          Text(label, style: const TextStyle(color: TColors.muted)),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  unit,
                  style: const TextStyle(color: TColors.muted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon, required this.accent});

  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: accent.withAlpha(28),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, color: accent),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(34),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: TColors.muted)),
      ],
    );
  }
}

class TrendChart extends StatelessWidget {
  const TrendChart({super.key, required this.readings});

  final List<PressureReading> readings;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Son ölçümlerin sistolik ve diyastolik eğilim grafiği',
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: CustomPaint(
          painter: _TrendPainter(readings.take(7).toList().reversed.toList()),
        ),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  const _TrendPainter(this.readings);

  final List<PressureReading> readings;

  @override
  void paint(Canvas canvas, Size size) {
    if (readings.length < 2) return;

    final grid = Paint()
      ..color = Colors.white.withAlpha(12)
      ..strokeWidth = 1;

    for (var i = 1; i < 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    _drawSeries(
      canvas,
      size,
      readings.map((e) => e.systolic.toDouble()).toList(),
      TColors.coral,
      100,
      160,
    );
    _drawSeries(
      canvas,
      size,
      readings.map((e) => e.diastolic.toDouble()).toList(),
      TColors.sky,
      60,
      105,
    );
  }

  void _drawSeries(
    Canvas canvas,
    Size size,
    List<double> values,
    Color color,
    double min,
    double max,
  ) {
    final path = Path();
    final line = Paint()
      ..color = color
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final dot = Paint()..color = color;

    for (var i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      final normalized = ((values[i] - min) / (max - min)).clamp(0.0, 1.0);
      final y = size.height - (normalized * size.height * 0.78) - 10;
      final point = Offset(x, y);

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }

      canvas.drawCircle(point, 3.2, dot);
    }

    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _TrendPainter oldDelegate) => true;
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.store});

  final ReadingStore store;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 124),
          children: [
            Text('Geçmiş', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 6),
            const Text(
              'Ölçümler, notlar ve bağlam tek zaman çizelgesinde.',
              style: TextStyle(color: TColors.muted),
            ),
            const SizedBox(height: 18),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'list', label: Text('Liste')),
                ButtonSegment(value: 'calendar', label: Text('Takvim')),
              ],
              selected: const {'list'},
              onSelectionChanged: (_) {},
            ),
            const SizedBox(height: 16),
            for (final reading in store.readings)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _ReadingTile(reading: reading),
              ),
          ],
        );
      },
    );
  }
}

class _ReadingTile extends StatelessWidget {
  const _ReadingTile({required this.reading});

  final PressureReading reading;

  @override
  Widget build(BuildContext context) {
    final hour = reading.takenAt.hour.toString().padLeft(2, '0');
    final minute = reading.takenAt.minute.toString().padLeft(2, '0');

    return PremiumCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(
              '$hour:$minute',
              style: const TextStyle(color: TColors.muted),
            ),
          ),
          Expanded(
            child: Text(
              reading.display,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            '${reading.pulse}',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 4),
          const Text('bpm', style: TextStyle(color: TColors.muted)),
          const SizedBox(width: 10),
          Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              color: TColors.mint,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key, required this.store});

  final ReadingStore store;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 124),
          children: [
            Text('Analiz', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 6),
            const Text(
              'Tek tek sayılarda kaybolmadan eğilimleri gör.',
              style: TextStyle(color: TColors.muted),
            ),
            const SizedBox(height: 18),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: '7', label: Text('7 Gün')),
                ButtonSegment(value: '30', label: Text('30 Gün')),
                ButtonSegment(value: '90', label: Text('90 Gün')),
              ],
              selected: const {'7'},
              onSelectionChanged: (_) {},
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AverageCard(
                    label: 'Ort. sistolik',
                    value: store.averageSystolic.round().toString(),
                    unit: 'mmHg',
                    accent: TColors.coral,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AverageCard(
                    label: 'Ort. diyastolik',
                    value: store.averageDiastolic.round().toString(),
                    unit: 'mmHg',
                    accent: TColors.sky,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AverageCard(
              label: 'Ort. nabız',
              value: store.averagePulse.round().toString(),
              unit: 'bpm',
              accent: TColors.violet,
            ),
            const SizedBox(height: 16),
            PremiumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Trend', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 14),
                  TrendChart(readings: store.readings),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const PremiumCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.auto_awesome_rounded, color: TColors.mint),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Akıllı içgörüler yalnızca yeterli veri olduğunda gösterilecek. Tensio tek bir ölçümden hikâye uydurmayacak.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class AverageCard extends StatelessWidget {
  const AverageCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.accent,
  });

  final String label;
  final String value;
  final String unit;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(height: 14),
          Text(label, style: const TextStyle(color: TColors.muted)),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(unit, style: const TextStyle(color: TColors.muted)),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 124),
      children: [
        Text(
          'Profil & Ayarlar',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 18),
        const PremiumCard(
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: TColors.coral,
                child: Icon(Icons.person_rounded, color: Colors.white),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tensio kullanıcısı',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Yerel profil',
                      style: TextStyle(color: TColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const SettingsGroup(
          items: [
            SettingsItem(Icons.person_outline_rounded, 'Kişisel bilgiler'),
            SettingsItem(Icons.flag_outlined, 'Hedefler'),
            SettingsItem(Icons.medication_outlined, 'İlaç takibi'),
            SettingsItem(Icons.health_and_safety_outlined, 'Doktor bilgileri'),
          ],
        ),
        const SizedBox(height: 12),
        const SettingsGroup(
          items: [
            SettingsItem(
              Icons.favorite_outline_rounded,
              'Apple Health / Health Connect',
            ),
            SettingsItem(Icons.watch_outlined, 'Cihazlar'),
            SettingsItem(
              Icons.notifications_none_rounded,
              'Hatırlatıcılar',
            ),
            SettingsItem(
              Icons.backup_outlined,
              'Yedekleme & dışa aktarma',
            ),
          ],
        ),
        const SizedBox(height: 12),
        const SettingsGroup(
          items: [
            SettingsItem(Icons.palette_outlined, 'Görünüm'),
            SettingsItem(Icons.language_rounded, 'Dil'),
            SettingsItem(Icons.lock_outline_rounded, 'Gizlilik & güvenlik'),
            SettingsItem(
              Icons.workspace_premium_outlined,
              'Tensio Premium',
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.items});

  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            items[i],
            if (i != items.length - 1)
              Divider(height: 1, color: Colors.white.withAlpha(12)),
          ],
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem(this.icon, this.label, {super.key});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right_rounded),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}

class MeasurementSheet extends StatefulWidget {
  const MeasurementSheet({super.key, required this.store});

  final ReadingStore store;

  @override
  State<MeasurementSheet> createState() => _MeasurementSheetState();
}

class _MeasurementSheetState extends State<MeasurementSheet> {
  final formKey = GlobalKey<FormState>();
  final systolic = TextEditingController(text: '120');
  final diastolic = TextEditingController(text: '80');
  final pulse = TextEditingController(text: '72');
  final note = TextEditingController();
  String contextLabel = 'Sabah';

  @override
  void dispose() {
    systolic.dispose();
    diastolic.dispose();
    pulse.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      margin: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
        color: TColors.midnightSoft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 28 + keyboard),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(44),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Yeni ölçüm',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Kapat',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Değerleri tansiyon aletinde gördüğün şekilde gir.',
                style: TextStyle(color: TColors.muted),
              ),
              const SizedBox(height: 22),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: NumberField(
                      controller: systolic,
                      label: 'Sistolik',
                      unit: 'mmHg',
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: NumberField(
                      controller: diastolic,
                      label: 'Diyastolik',
                      unit: 'mmHg',
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: NumberField(
                      controller: pulse,
                      label: 'Nabız',
                      unit: 'bpm',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Zaman etiketi',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Sabah', 'Öğle', 'Akşam', 'Gece']
                    .map(
                      (value) => ChoiceChip(
                        label: Text(value),
                        selected: contextLabel == value,
                        onSelected: (_) {
                          setState(() => contextLabel = value);
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: note,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Not (isteğe bağlı)',
                  hintText: 'Örn. dinlenme sonrası, kahve sonrası…',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton.icon(
                  onPressed: save,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Ölçümü kaydet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    widget.store.add(
      PressureReading(
        systolic: int.parse(systolic.text),
        diastolic: int.parse(diastolic.text),
        pulse: int.parse(pulse.text),
        takenAt: DateTime.now(),
        context: contextLabel,
        note: note.text.trim().isEmpty ? null : note.text.trim(),
      ),
    );

    Navigator.of(context).pop();
  }
}

class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.controller,
    required this.label,
    required this.unit,
  });

  final TextEditingController controller;
  final String label;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        final parsed = int.tryParse(value ?? '');
        if (parsed == null || parsed <= 0) return 'Gerekli';
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        helperText: unit,
        alignLabelWithHint: true,
      ),
    );
  }
}
