// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/home_page/main_tabs/stats_page/preview_screen.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../common_widgets/widgets.dart';
import '../../../../globals.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);
  @override
  State<StatsPage> createState() => StatsPageState();
}

class StatsPageState extends State<StatsPage> {
  static late GlobalKey<SfCartesianChartState> cartesianChartKey1;
  static late GlobalKey<SfCircularChartState> cartesianChartKey2;
  static late GlobalKey<SfCartesianChartState> cartesianChartKey3;
  late List<SalesData> _chartData1;
  late List<ChartData> _chartData2;
  late num totalInitiated, totalApproved;
  late double rate;
  String year = DateTime.now().year.toString();
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // Timer.periodic(Duration(days: 30), updateDataSource);
    cartesianChartKey1 = GlobalKey();
    cartesianChartKey2 = GlobalKey();
    cartesianChartKey3 = GlobalKey();
    // _chartData1 = getChartData1();
    // _chartData2 = getChartData2();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  //int index = 0;
  // void updateDataSource(Timer timer) {
  //   _chartData1.add(SalesData(monthsName[index++], approvedMous[index++]));
  //   _chartData1.remove(0);
  // }

  List<double> approvedMous = [
    21,
    24,
    35,
    38,
    54,
    21,
    24,
    35,
    38,
    54,
    38,
    54,
  ];

  List<String> monthsName = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<ChartData> getChartData2() {
    final List<ChartData> chartData2 = [
      ChartData('Approved', 12.5, COLOR_THEME['primary']!),
      ChartData('Not  Approved', 100 - 12.5, hexStringToColor("C4C4C4")),
    ];
    return chartData2;
  }

  List<SalesData> getChartData1() {
    final List<SalesData> chartData = [
      SalesData('Jan', 21),
      SalesData('Feb', 24),
      SalesData('Mar', 35),
      SalesData('Apr', 38),
      SalesData('May', 54),
      SalesData('Jun', 21),
      SalesData('Jul', 24),
      SalesData('Aug', 35),
      SalesData('Sep', 38),
      SalesData('Oct', 54),
      SalesData('Nov', 38),
      SalesData('Dec', 54)
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: cartesianChartKey3,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: width * 0.1),
        child: SavePDF(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      appBar: appBar("Report-$year", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: FutureBuilder(
                  future: DataBaseService().getStats("total_approved", "2023"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data as List;
                      _chartData1 = [];
                      totalApproved = 0;
                      for (int i = 0; i < 11; i++) {
                        _chartData1.add(SalesData(monthsName[i], data[i]));
                        totalApproved += data[i];
                      }
                      return lineChart();
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                    future:
                        DataBaseService().getStats("total_initiated", "2023"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data as List;
                        totalInitiated = 0;
                        _chartData2 = [];
                        for (int i = 0; i < 11; i++) {
                          totalInitiated += data[i];
                        }
                        rate = (totalApproved / totalInitiated) * 100;
                        print(rate);
                        _chartData2.add(ChartData(
                            'Approved', rate, COLOR_THEME['primary']!));
                        _chartData2.add(ChartData('Not  Approved', 100 - rate,
                            hexStringToColor("C4C4C4")));

                        return approvalRate();
                      } else
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget approvalRate() {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
      child: SfCircularChart(
        key: cartesianChartKey2,
        backgroundColor: hexStringToColor("EDF9FF"),
        title: ChartTitle(
            text: "Approval Rate",
            textStyle: GoogleFonts.figtree(fontWeight: FontWeight.bold)),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Container(
              child: PText(
                '${rate.toString().substring(0, 4)}%',
                style: GoogleFonts.figtree(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
              strokeWidth: 1,
              dataSource: _chartData2,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y)
        ],
      ),
    );
  }

  ClipRRect lineChart() {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.5),
        ),
        // padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: SfCartesianChart(
          //isTransposed: true,
          key: cartesianChartKey1,
          backgroundColor: hexStringToColor("EDF9FF"),
          title: ChartTitle(
              text: "Monthly Approved MOU's",
              textStyle: TextStyle(fontWeight: FontWeight.bold)),
          //legend: Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            SplineSeries<SalesData, String>(
              //name: 'Sales',
              markerSettings: MarkerSettings(isVisible: true),
              color: Colors.black,
              dataSource: _chartData1,
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.sales,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
            )
          ],
          primaryXAxis: CategoryAxis(
            name: "Months",
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            maximumLabels: 5,
          ),
          // primaryYAxis: NumericAxis(
          //     labelFormat: '{value}M',
          //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);
  final String month;
  final int sales;
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class SavePDF extends StatefulWidget {
  const SavePDF({Key? key}) : super(key: key);

  @override
  State<SavePDF> createState() => SavePDFState();
}

class SavePDFState extends State<SavePDF> {
  @override
  Widget build(BuildContext context) {
    return _floating();
  }

  FloatingActionButton _floating() {
    return FloatingActionButton(
      onPressed: displayPdf,
      backgroundColor: Colors.black,
      child: const Icon(Icons.picture_as_pdf),
    );
  }

  void displayPdf() async {
    final ui.Image data1 = await StatsPageState.cartesianChartKey1.currentState!
        .toImage(pixelRatio: 3.0);
    final ByteData? bytes1 =
        await data1.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes1 =
        bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);

    final ui.Image data2 =
        await (StatsPageState.cartesianChartKey2.currentState)!
            .toImage(pixelRatio: 3.0);
    final ByteData? bytes2 =
        await data2.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes2 =
        bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(imageBytes1, imageBytes2);
        },
      ),
    );

    /// open Preview Screen
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => PreviewScreen(doc: doc),
    ));
  }

  buildPrintableData(Uint8List imageBytes1, Uint8List imageBytes2) {
    final image1 = pw.MemoryImage(imageBytes1);
    final image2 = pw.MemoryImage(imageBytes2);
    return pw.Wrap(
      alignment: pw.WrapAlignment.center,
      crossAxisAlignment: pw.WrapCrossAlignment.start,
      runSpacing: 20,
      children: [
        pw.Container(
          width: MediaQuery.of(context).size.width * 1.25,
          height: 300,
          decoration: pw.BoxDecoration(
            image: pw.DecorationImage(
              fit: pw.BoxFit.fill,
              image: image1,
            ),
          ),
        ),
        pw.Container(
          width: MediaQuery.of(context).size.width * 1.25,
          height: 300,
          decoration: pw.BoxDecoration(
            image: pw.DecorationImage(
              fit: pw.BoxFit.fill,
              image: image2,
            ),
          ),
        ),
      ],
    );
  }
}
