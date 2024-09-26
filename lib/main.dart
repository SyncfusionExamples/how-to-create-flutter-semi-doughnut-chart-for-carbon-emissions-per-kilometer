import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SemiDoughnutVisualization(),
    );
  }
}

class SemiDoughnutVisualization extends StatefulWidget {
  const SemiDoughnutVisualization({super.key});

  @override
  State<SemiDoughnutVisualization> createState() =>
      _SemiDoughnutVisualizationState();
}

class _SemiDoughnutVisualizationState extends State<SemiDoughnutVisualization> {
  late List<SemiDoughnutChartData> _semiDoughnutChartData;
  late String _largestSectorLabel;

  @override
  void initState() {
    super.initState();
    _semiDoughnutChartData = _createSemiDoughnutChartData();
    _largestSectorLabel = _buildLargestSectorLabel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Semi-Doughnut Chart for Visualizing India's Employment Sectors",
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      body: Center(
        child: SfCircularChart(
          annotations: _buildChartAnnotations(),
          series: <CircularSeries>[
            _buildDoughnutSeries(),
          ],
        ),
      ),
    );
  }

  String _buildLargestSectorLabel() {
    final largestSector = _semiDoughnutChartData.reduce(
      (current, next) => current.y > next.y ? current : next,
    );
    return largestSector.x;
  }

  List<CircularChartAnnotation> _buildChartAnnotations() {
    return <CircularChartAnnotation>[
      _buildIconAnnotation(-6, Icons.emoji_transportation_outlined,
          const Color.fromRGBO(255, 189, 57, 1)),
      _buildIconAnnotation(-85, Icons.agriculture_outlined,
          const Color.fromARGB(255, 28, 178, 1)),
      _buildIconAnnotation(
          -24, Icons.restaurant, const Color.fromARGB(255, 0, 156, 228)),
      _buildIconAnnotation(-142, Icons.precision_manufacturing_outlined,
          const Color.fromARGB(255, 199, 3, 163)),
      _buildIconAnnotation(-167, Icons.construction_outlined,
          const Color.fromARGB(255, 249, 87, 38)),
      _buildCenterTextAnnotation()
    ];
  }

  CircularChartAnnotation _buildIconAnnotation(
      int angle, IconData icon, Color color) {
    return CircularChartAnnotation(
      angle: angle,
      widget: Container(
        alignment: Alignment.center,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Icon(icon, size: 25),
      ),
      radius: '90%',
    );
  }

  CircularChartAnnotation _buildCenterTextAnnotation() {
    return CircularChartAnnotation(
      widget: Center(
        child: SizedBox(
          width: 200,
          height: 125,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _largestSectorLabel.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
              ),
              Text(
                'Distribution of workers in India across broad industries',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DoughnutSeries<SemiDoughnutChartData, String> _buildDoughnutSeries() {
    return DoughnutSeries<SemiDoughnutChartData, String>(
      radius: '90%',
      dataSource: _semiDoughnutChartData,
      xValueMapper: (SemiDoughnutChartData data, int index) => data.x,
      yValueMapper: (SemiDoughnutChartData data, int index) => data.y,
      pointColorMapper: (SemiDoughnutChartData data, int index) => data.color,
      dataLabelMapper: (SemiDoughnutChartData data, int index) => data.x,
      startAngle: 270,
      endAngle: 90,
      animationDuration: 0,
      dataLabelSettings: const DataLabelSettings(
        labelIntersectAction: LabelIntersectAction.none,
        isVisible: true,
        textStyle: TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static List<SemiDoughnutChartData> _createSemiDoughnutChartData() {
    return [
      SemiDoughnutChartData(
          'Construction', 12.6, const Color.fromARGB(255, 249, 87, 38)),
      SemiDoughnutChartData(
          'Manufacturing', 11.6, const Color.fromARGB(255, 199, 3, 163)),
      SemiDoughnutChartData(
          'Agriculture', 45.5, const Color.fromARGB(255, 28, 178, 1)),
      SemiDoughnutChartData(
          'Restaurant', 12.1, const Color.fromARGB(255, 0, 156, 228)),
      SemiDoughnutChartData(
          'Transport', 5.6, const Color.fromRGBO(255, 189, 57, 1)),
    ];
  }
}

class SemiDoughnutChartData {
  SemiDoughnutChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
