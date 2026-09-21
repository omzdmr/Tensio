import 'package:flutter/material.dart';
import 'package:tensio/core/design/tensio_colors.dart';
import 'package:tensio/core/widgets/surface_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Merhaba', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 4),
                  const Text('Bugünkü ölçümlerin tek bakışta burada.', style: TextStyle(color: TensioColors.textSecondary)),
                ]),
              ),
              const CircleAvatar(radius: 22, backgroundColor: TensioColors.surfaceStrong, child: Icon(Icons.person_rounded)),
            ],
          ),
          const SizedBox(height: 20),
          const SurfaceCard(
            backgroundColor: Color(0xFF0A3A2D),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text('SON ÖLÇÜM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: .8, color: Color(0xFFA8E8CB)))),
                Icon(Icons.favorite_rounded, color: TensioColors.emerald),
              ]),
              SizedBox(height: 12),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('120 / 80', style: TextStyle(fontSize: 38, height: 1, fontWeight: FontWeight.w700, letterSpacing: -1.2)),
                SizedBox(width: 8),
                Padding(padding: EdgeInsets.only(bottom: 4), child: Text('mmHg', style: TextStyle(color: Color(0xFFB6C8C0)))),
              ]),
              SizedBox(height: 12),
              Text('72 bpm  •  Bugün 08:30', style: TextStyle(color: Color(0xFFB6C8C0))),
            ]),
          ),
          const SizedBox(height: 16),
          const Row(children: [
            Expanded(child: _QuickAction(icon: Icons.add_chart_rounded, label: 'Yeni Ölçüm', tint: TensioColors.coral)),
            SizedBox(width: 10),
            Expanded(child: _QuickAction(icon: Icons.description_outlined, label: 'Raporlar', tint: TensioColors.blue)),
            SizedBox(width: 10),
            Expanded(child: _QuickAction(icon: Icons.notifications_none_rounded, label: 'Hatırlat', tint: TensioColors.amber)),
          ]),
          const SizedBox(height: 16),
          SurfaceCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text('7 günlük görünüm', style: Theme.of(context).textTheme.titleLarge)),
                const Text('Detay', style: TextStyle(color: TensioColors.blue, fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 18),
              const SizedBox(height: 120, child: _TrendPreview()),
              const SizedBox(height: 12),
              const Text('Sistolik ve diyastolik trendleri burada birlikte okunacak.', style: TextStyle(color: TensioColors.textSecondary)),
            ]),
          ),
          const SizedBox(height: 16),
          const SurfaceCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Bugün', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 14),
              _RoutineRow(icon: Icons.wb_sunny_outlined, title: 'Sabah ölçümü', detail: '08:00', done: true),
              Divider(height: 24),
              _RoutineRow(icon: Icons.nights_stay_outlined, title: 'Akşam ölçümü', detail: '20:00', done: false),
            ]),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.tint});
  final IconData icon;
  final String label;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(color: tint.withOpacity(.14), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: tint),
        ),
        const SizedBox(height: 9),
        Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge),
      ]),
    );
  }
}

class _TrendPreview extends StatelessWidget {
  const _TrendPreview();
  @override
  Widget build(BuildContext context) => CustomPaint(painter: _TrendPainter(), child: const SizedBox.expand());
}

class _TrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()..color = TensioColors.outline..strokeWidth = 1;
    for (var i=1; i<4; i++) {
      final y=size.height*i/4;
      canvas.drawLine(Offset(0,y), Offset(size.width,y), grid);
    }
    void series(List<double> values, Color color) {
      final p=Path();
      for (var i=0; i<values.length; i++) {
        final x=size.width*i/(values.length-1);
        final y=size.height*(1-values[i]);
        if(i==0){p.moveTo(x,y);}else{p.lineTo(x,y);}
      }
      canvas.drawPath(p, Paint()..color=color..strokeWidth=2.5..style=PaintingStyle.stroke..strokeCap=StrokeCap.round..strokeJoin=StrokeJoin.round);
    }
    series(const [.62,.55,.67,.58,.63,.52,.60], TensioColors.coral);
    series(const [.34,.31,.39,.35,.36,.29,.33], TensioColors.blue);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}

class _RoutineRow extends StatelessWidget {
  const _RoutineRow({required this.icon, required this.title, required this.detail, required this.done});
  final IconData icon; final String title; final String detail; final bool done;
  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, color: done ? TensioColors.emerald : TensioColors.amber),
    const SizedBox(width:12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      Text(detail, style: const TextStyle(color:TensioColors.textSecondary)),
    ])),
    Icon(done ? Icons.check_circle_rounded : Icons.circle_outlined, color: done ? TensioColors.emerald : TensioColors.textMuted),
  ]);
}
