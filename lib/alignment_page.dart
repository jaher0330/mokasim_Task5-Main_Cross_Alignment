import 'package:flutter/material.dart';

class AlignmentExample {
  final String title;
  final bool isRow;
  final bool isCross;
  final MainAxisAlignment main;
  final CrossAxisAlignment cross;

  const AlignmentExample({
    required this.title,
    required this.isRow,
    required this.isCross,
    this.main = MainAxisAlignment.start,
    this.cross = CrossAxisAlignment.center,
  });
}

class AlignmentPage extends StatefulWidget {
  const AlignmentPage({super.key});

  @override
  State<AlignmentPage> createState() => _AlignmentPageState();
}

class _AlignmentPageState extends State<AlignmentPage> {
  int _index = 0;

  static const Map<String, MainAxisAlignment> _mainValues = {
    'center': MainAxisAlignment.center,
    'spaceAround': MainAxisAlignment.spaceAround,
    'spaceBetween': MainAxisAlignment.spaceBetween,
    'spaceEvenly': MainAxisAlignment.spaceEvenly,
    'start': MainAxisAlignment.start,
    'end': MainAxisAlignment.end,
  };

  static const Map<String, CrossAxisAlignment> _crossValues = {
    'start': CrossAxisAlignment.start,
    'end': CrossAxisAlignment.end,
    'baseline': CrossAxisAlignment.baseline,
    'center': CrossAxisAlignment.center,
    'stretch': CrossAxisAlignment.stretch,
  };

  late final List<AlignmentExample> _examples = _buildExamples();

  List<AlignmentExample> _buildExamples() {
    final list = <AlignmentExample>[];
    for (final isRow in [true, false]) {
      final widgetName = isRow ? 'Row' : 'Column';
      for (final e in _mainValues.entries) {
        list.add(AlignmentExample(
          title: '$widgetName - MainAxisAlignment.${e.key}',
          isRow: isRow,
          isCross: false,
          main: e.value,
        ));
      }
      for (final e in _crossValues.entries) {
        list.add(AlignmentExample(
          title: '$widgetName - CrossAxisAlignment.${e.key}',
          isRow: isRow,
          isCross: true,
          cross: e.value,
        ));
      }
    }
    return list;
  }

  Widget _box(Color color, double w, double h, String label, double fontSize) {
    return Container(
      width: w,
      height: h,
      color: color,
      child: Text(label, style: TextStyle(fontSize: fontSize)),
    );
  }

  // Equal boxes for MainAxisAlignment examples
  List<Widget> _mainChildren() => [
        _box(Colors.red, 50, 50, 'A', 20),
        _box(Colors.yellow, 50, 50, 'B', 20),
        _box(Colors.blue, 50, 50, 'C', 20),
      ];

  // Different sizes for CrossAxisAlignment examples
  List<Widget> _crossChildren() => [
        _box(Colors.red, 50, 60, 'A', 16),
        _box(Colors.yellow, 50, 90, 'B', 28),
        _box(Colors.blue, 50, 120, 'C', 40),
      ];

  Widget _demo(AlignmentExample ex) {
    final children = ex.isCross ? _crossChildren() : _mainChildren();

    final Widget flex = ex.isRow
        ? Row(
            mainAxisAlignment: ex.main,
            crossAxisAlignment: ex.cross,
            textBaseline: TextBaseline.alphabetic,
            children: children,
          )
        : Column(
            mainAxisAlignment: ex.main,
            crossAxisAlignment: ex.cross,
            textBaseline: TextBaseline.alphabetic,
            children: children,
          );

    return Container(
      width: double.infinity,
      height: ex.isRow ? 250 : 420,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: flex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ex = _examples[_index];

    return Scaffold(
      appBar: AppBar(
        title: const Text('TASK 5 - MOKASIM'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              ex.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _demo(ex),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _index > 0 ? () => setState(() => _index--) : null,
                  child: const Text('Previous'),
                ),
                Text('${_index + 1} / ${_examples.length}'),
                ElevatedButton(
                  onPressed: _index < _examples.length - 1
                      ? () => setState(() => _index++)
                      : null,
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 