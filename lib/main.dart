import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ChartData> chartData = _createChartData();

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
        /// Builds the entire doughnut chart
        child: SfCircularChart(
          annotations: _buildChartAnnotations(),
          series: <CircularSeries>[
            _buildDoughnutSeries(),
          ],
        ),
      ),
    );
  }

  /// Creates reusable chart annotations
  List<CircularChartAnnotation> _buildChartAnnotations() {
    return <CircularChartAnnotation>[
      _buildIconAnnotation(-6, Icons.emoji_transportation_outlined,
          const Color.fromARGB(255, 244, 232, 1)),
      _buildIconAnnotation(-85, Icons.agriculture_outlined,
          const Color.fromARGB(255, 28, 178, 1)),
      _buildIconAnnotation(
          -24, Icons.restaurant, const Color.fromARGB(255, 0, 156, 228)),
      _buildIconAnnotation(-142, Icons.precision_manufacturing_outlined,
          const Color.fromARGB(255, 199, 3, 163)),
      _buildIconAnnotation(-167, Icons.construction_outlined,
          const Color.fromARGB(255, 231, 139, 1)),
      _buildTextAnnotation()
    ];
  }

  /// Reusable icon annotation widget
  CircularChartAnnotation _buildIconAnnotation(
      int angle, IconData icon, Color color) {
    return CircularChartAnnotation(
      angle: angle,
      widget: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(
          child: Icon(icon, size: 25),
        ),
      ),
      radius: '90%',
    );
  }

  /// Text annotation widget for the doughnut chart
  CircularChartAnnotation _buildTextAnnotation() {
    return CircularChartAnnotation(
      widget: Center(
        child: SizedBox(
          width: 200,
          height: 125,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "AGRICULTURE",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                "share of workers in India across broad industries ",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the doughnut series with necessary configurations
  DoughnutSeries<ChartData, String> _buildDoughnutSeries() {
    return DoughnutSeries<ChartData, String>(
      radius: '90%',
      dataSource: chartData,
      xValueMapper: (ChartData data, int index) => data.x,
      yValueMapper: (ChartData data, int index) => data.y,
      pointColorMapper: (ChartData data, int index) => data.color,
      dataLabelMapper: (ChartData data, int index) => data.x,
      startAngle: 270,
      endAngle: 90,
      animationDuration: 0,
      explode: true,
      explodeAll: true,
      explodeOffset: '2%',
      dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
    );
  }

  /// Creates a list of chart data
  static List<ChartData> _createChartData() {
    return [
      ChartData('Construction', 12.6, const Color.fromARGB(255, 231, 139, 1)),
      ChartData('Manufacturing', 11.6, const Color.fromARGB(255, 199, 3, 163)),
      ChartData('Agriculture', 45.5, const Color.fromARGB(255, 28, 178, 1)),
      ChartData('Restaurant', 12.1, const Color.fromARGB(255, 0, 156, 228)),
      ChartData('Transport', 5.6, const Color.fromARGB(255, 244, 232, 1)),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
