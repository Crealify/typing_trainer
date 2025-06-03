import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:typing_trainer/data/models/typing_stats.dart';
import 'package:typing_trainer/presentation/providers/typing_providers.dart';

class StatsPanel extends StatelessWidget {
  const StatsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TypingProvider>();
    final wpm = provider.isTyping && provider.startTime != null
        ? provider.calculateWPM(DateTime.now().difference(provider.startTime!))
        : 0;
    final accuracy = provider.isTyping ? provider.calculateAccuracy() : 0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatTile(
              title: 'WPM',
              value: wpm.toStringAsFixed(1),
              color: Colors.blue,
            ),
            StatTile(
              title: 'Accuracy',
              value: '${accuracy.toStringAsFixed(1)}%',
              color: Colors.green,
            ),
            StatTile(
              title: 'Chars',
              value:
                  '${provider.userInput.length}/${provider.currentText.length}',
              color: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(height: 150, child: HistoryChart(stats: provider.history)),
      ],
    );
  }
}

class StatTile extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatTile({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.labelSmall),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class HistoryChart extends StatelessWidget {
  final List<TypingStats> stats;

  const HistoryChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: stats.asMap().entries.map((e) {
              return FlSpot(e.key.toDouble(), e.value.wpm);
            }).toList(),
            isCurved: true,
            color: Theme.of(context).colorScheme.primary,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(),
          topTitles: AxisTitles(),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }
}
