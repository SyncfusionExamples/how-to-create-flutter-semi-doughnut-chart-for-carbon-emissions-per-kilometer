import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<CarbonEmission> carbonEmission = [
    CarbonEmission(
        'Bus', 97, Icons.directions_bus_outlined, const Color(0xff036666)),
    CarbonEmission('Flight', 246, Icons.flight, const Color(0xff248277)),
    CarbonEmission(
        'Motorbike', 114, Icons.pedal_bike_outlined, const Color(0xff469D89)),
    CarbonEmission('Electric car', 47, Icons.directions_car_filled_outlined,
        const Color(0xff67B99A)),
    CarbonEmission('National rail', 35, Icons.directions_railway_filled_sharp,
        const Color(0xff88D4AB)),
  ];

  late String _largestSectorLabel;

  @override
  void initState() {
    _largestSectorLabel = _buildLargestSectorLabel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SfCircularChart(
            annotations: [_buildCenterTextAnnotation()],
            series: <CircularSeries>[
              DoughnutSeries<CarbonEmission, String>(
                radius: '60%',
                startAngle: 270,
                endAngle: 90,
                strokeColor: Colors.white,
                strokeWidth: 3,
                explode: true,
                dataSource: carbonEmission,
                xValueMapper: (CarbonEmission data, int index) => data.x,
                yValueMapper: (CarbonEmission data, int index) => data.y,
                pointColorMapper: (CarbonEmission data, int index) =>
                    data.color,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: data.color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            data.icon,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          data.x,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    );
                  },
                  labelPosition: ChartDataLabelPosition.outside,
                  labelIntersectAction: LabelIntersectAction.none,
                  connectorLineSettings:
                      const ConnectorLineSettings(length: '5%'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildLargestSectorLabel() {
    final largestSector = carbonEmission.reduce(
      (current, next) => current.y > next.y ? current : next,
    );
    return largestSector.x;
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
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
              ),
              const Text(
                'Carbon footprint of travel per kilometer',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarbonEmission {
  CarbonEmission(this.x, this.y, this.icon, this.color);
  final String x;
  final double y;
  final IconData icon;
  final Color color;
}
