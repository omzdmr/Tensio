import 'package:flutter/material.dart';
import 'package:tensio/core/design/tensio_colors.dart';

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({required this.child, super.key, this.padding = const EdgeInsets.all(16), this.onTap, this.backgroundColor});
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? TensioColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: TensioColors.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(onTap: onTap, child: Padding(padding: padding, child: child)),
    );
  }
}
