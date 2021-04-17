import 'dart:ffi';

import 'package:face_water_dispenser/page/layout.dart';
import 'package:face_water_dispenser/repository/monitor_msg_entity.dart';
import 'package:face_water_dispenser/repository/monitor_used_water_time_msg_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../main_logic.dart';
import '../../main_state.dart';
import '../noLogin.dart';
import 'logic.dart';
import 'state.dart';

class MonitorItem {
  String name;
  IconData icon;
  Color color;

  MonitorItem(this.name, this.icon, this.color);
}

class MonitorPage extends StatelessWidget {
  final MonitorLogic logic = Get.put(MonitorLogic());
  final MonitorState state = Get.find<MonitorLogic>().state;
  final MainState _mainState = Get.find<MainLogic>().state;

  final _key = GlobalKey();
  CupertinoThemeData theme;

  Widget _buildFlowItem(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        sliver: SliverToBoxAdapter(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("今日用水趋势",
                style: TextStyle(
                    color: theme.textTheme.navTitleTextStyle.color,
                    fontSize: 25,
                    fontWeight: theme.textTheme.navTitleTextStyle.fontWeight)),
            CupertinoPopupSurface(
                child: AspectRatio(
                    aspectRatio: 1 / 0.618,
                    child: Container(
                        color: theme.barBackgroundColor,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Obx(() => LineChart(
                                sampleData2(state.monitorUsedWaterTimeMsg.value
                                    .toList()),
                                swapAnimationDuration:
                                    Duration(milliseconds: 150),
                                swapAnimationCurve: Curves.linear, // Optional
                              )),
                        ))))
          ],
        )));
  }

  Widget _buildMonitorItem<T>(
      BuildContext context, MonitorItem item, Widget textWidget) {
    return CupertinoPopupSurface(
        child: Container(
            padding: EdgeInsets.all(10),
            color: theme.barBackgroundColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: ShapeDecoration(
                          color: item.color, shape: CircleBorder()),
                      child: Icon(item.icon,
                          color: CupertinoColors.systemBackground),
                    ),
                    Spacer(),
                    Text(
                      item.name,
                      style: TextStyle(
                          color: theme.textTheme.tabLabelTextStyle.color),
                    ),
                  ],
                ),
                Spacer(flex: 1),
                textWidget
              ],
            )));
  }

  Widget _buildMonitorItems(BuildContext context) {
    List<MonitorItem> _items = <MonitorItem>[
      MonitorItem("温度", CupertinoIcons.thermometer, CupertinoColors.systemRed),
      MonitorItem("水位", CupertinoIcons.drop, CupertinoColors.systemBlue),
      MonitorItem("锁定", CupertinoIcons.lock, CupertinoColors.systemOrange),
      MonitorItem("流量", CupertinoIcons.thermometer, CupertinoColors.systemTeal),
    ];
    final textStyle = TextStyle(
        color: theme.textTheme.navTitleTextStyle.color,
        fontSize: 28,
        fontWeight: theme.textTheme.navTitleTextStyle.fontWeight);
    Widget _buildObx(int index) {
      switch (index) {
        case 0:
          {
            return Obx(() =>
                Text(_mainState.monitorMsg.value.temp.toString(), style: textStyle));
          }
        case 1:
          {
            return Obx(() => Text(_mainState.monitorMsg.value.waterLevel.toString(),
                style: textStyle));
          }
        case 2:
          {
            return Obx(() => Text(_mainState.monitorMsg.value.waterLevel.toString(),
                style: textStyle));
          }
        case 3:
          {
            return Obx(() => Text(_mainState.monitorMsg.value.flowLimit.toString(),
                style: textStyle));
          }
      }
      return Obx(() => Text("0"));
    }

    return SliverPadding(
      padding: EdgeInsets.all(20),
      sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 0.5,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return _buildMonitorItem(context, _items[index], _buildObx(index));
          }, childCount: 4)),
    );
  }

  @override
  Widget build(BuildContext context) {
    theme = CupertinoTheme.of(context);
    return LayoutPage(
      key: _key,
      title: "监控",
      onRefresh: () async {
        await logic.getMonitorMsg();
      },
      trailings: [
        Container(
            child: Obx(
          () => Icon(CupertinoIcons.circle_fill,
              size: theme.textTheme.textStyle.fontSize,
              color: _mainState.onlined.value
                  ? CupertinoColors.systemGreen
                  : CupertinoColors.systemRed),
        )),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            print(_mainState.onlined.value);
            print(_mainState.logined.value);
          },
          child: Icon(CupertinoIcons.qrcode_viewfinder),
        ),
      ],
      slivers: _mainState.logined.value
          ? [
              _buildMonitorItems(context),
              _buildFlowItem(context),
            ]
          : [
              SliverToBoxAdapter(child: NoLoginPage()),
            ],
    );
  }

  LineChartData sampleData2(List<MonitorUsedWaterTimeMsgEntity> list) {
    return LineChartData(
      // backgroundColor: theme.barBackgroundColor,
      lineTouchData: LineTouchData(
        enabled: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 0,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          margin: 5,
          getTitles: (value) {
            return value.toInt().toString();
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            return (value).toInt().toString();
          },
          margin: 5,
          reservedSize: 15,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 1,
            ),
            left: BorderSide(
              color: Color(0xff4e4965),
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 23,
      maxY: 100,
      minY: 0,
      lineBarsData: linesBarData2(list),
    );
  }

  List<LineChartBarData> linesBarData2(
      List<MonitorUsedWaterTimeMsgEntity> list) {
    List<FlSpot> _buildList() {
      List<FlSpot> l = <FlSpot>[];
      for (int i = 0; i < list.length; i++) {
        FlSpot item = FlSpot(list[i].hour, list[i].val);
      }
      return l;
    }

    return [
      LineChartBarData(
        spots: _buildList(),
        isCurved: true,
        colors: const [
          CupertinoColors.systemBlue,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: false, colors: []),
      ),
    ];
  }
}

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                const Text(
                  'Unfold Shop 2018',
                  style: TextStyle(
                    color: Color(0xff827daa),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Monthly Sales',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      isShowingMainData ? sampleData1() : sampleData2(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
