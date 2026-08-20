import 'package:flutter/material.dart';

class FlyToCartController {
  static void fly({
    required BuildContext context,
    required GlobalKey fromKey,
    required GlobalKey toKey,
    required Widget flyingWidget,
    VoidCallback? onComplete,
  }) {
    final overlay = Overlay.of(context);

    // 1. هات مكان وحجم زرار "Add to Cart"
    final fromBox = fromKey.currentContext!.findRenderObject() as RenderBox;
    final fromPosition = fromBox.localToGlobal(Offset.zero);
    final fromSize = fromBox.size;

    // 2. هات مكان أيقونة الكارت في الـ AppBar
    final toBox = toKey.currentContext!.findRenderObject() as RenderBox;
    final toPosition = toBox.localToGlobal(Offset.zero);
    final toSize = toBox.size;

    // نقطة البداية = منتصف الزرار
    final startOffset = Offset(
      fromPosition.dx + fromSize.width / 2,
      fromPosition.dy + fromSize.height / 2,
    );

    // نقطة النهاية = منتصف أيقونة الكارت
    final endOffset = Offset(
      toPosition.dx + toSize.width / 2,
      toPosition.dy + toSize.height / 2,
    );

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _FlyingWidget(
        start: startOffset,
        end: endOffset,
        child: flyingWidget,
        onComplete: () {
          entry.remove();
          onComplete?.call();
        },
      ),
    );

    overlay.insert(entry);
  }
}

class _FlyingWidget extends StatefulWidget {
  const _FlyingWidget({
    required this.start,
    required this.end,
    required this.child,
    required this.onComplete,
  });

  final Offset start;
  final Offset end;
  final Widget child;
  final VoidCallback onComplete;

  @override
  State<_FlyingWidget> createState() => _FlyingWidgetState();
}

class _FlyingWidgetState extends State<_FlyingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // 👇 الحجم بيكبر شوية في النص، وبعدين يصغر بسرعة في الآخر (إحساس "قفزة" مش انزلاق ممل)
    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.15,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.15,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInBack)),
        weight: 70,
      ),
    ]).animate(_controller);

    // 👇 الشفافية تفضل كاملة لحد آخر 15% بس، وبعدين تختفي بسرعة
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward().whenComplete(widget.onComplete);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final arcHeight = -80 * (t < 0.5 ? t * 2 : (1 - t) * 2);

        final currentOffset = Offset.lerp(widget.start, widget.end, t)!;

        return Positioned(
          left: currentOffset.dx,
          top: currentOffset.dy + arcHeight,
          child: Opacity(
            opacity: _opacity.value,
            child: Transform.scale(scale: _scale.value, child: widget.child),
          ),
        );
      },
    );
  }
}
