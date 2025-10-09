// import 'package:flutter/material.dart';
// import 'package:graphic/graphic.dart' as graphic;

// class RadarChartGraphic extends StatelessWidget {
//   const RadarChartGraphic({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final data = [
//       {'metric': 'Sleep Quality', 'type': 'Actual', 'value': 3.0},
//       {'metric': 'Physical Activity', 'type': 'Actual', 'value': 4.0},
//       {'metric': 'Hydration', 'type': 'Actual', 'value': 2.5},
//       {'metric': 'Stress Mgmt', 'type': 'Actual', 'value': 4.5},
//       {'metric': 'Other', 'type': 'Actual', 'value': 3.5},

//       {'metric': 'Sleep Quality', 'type': 'Goal', 'value': 5.0},
//       {'metric': 'Physical Activity', 'type': 'Goal', 'value': 5.0},
//       {'metric': 'Hydration', 'type': 'Goal', 'value': 5.0},
//       {'metric': 'Stress Mgmt', 'type': 'Goal', 'value': 5.0},
//       {'metric': 'Other', 'type': 'Goal', 'value': 5.0},
//     ];

//     return SizedBox(
//       height: 400,
//       child: graphic.Chart(
//         data: data,
//         variables: {
//           'metric': graphic.Variable(
//             accessor: (map) =>
//                 (map as Map<String, dynamic>?)?['metric'] as String? ?? '',
//           ),
//           'value': graphic.Variable(
//             accessor: (map) =>
//                 (map as Map<String, dynamic>?)?['value'] as num? ?? 0,
//           ),
//           'type': graphic.Variable(
//             accessor: (map) =>
//                 (map as Map<String, dynamic>?)?['type'] as String? ?? '',
//           ),
//         },
//         marks: [
//           graphic.LineMark(
//             position: graphic.Varset('metric') * graphic.Varset('value'),
//             color: graphic.ColorEncode(
//               variable: 'type',
//               values: [Colors.orange, Colors.green],
//             ),
//             shape: graphic.ShapeEncode(
//               variable: 'type',
//               values: [
//                 graphic.BasicLineShape(),
//                 graphic.BasicLineShape(dash: [6, 4]), // 👈 dotted
//               ],
//             ),
//           ),
//           graphic.AreaMark(
//             position: graphic.Varset('metric') * graphic.Varset('value'),
//             color: graphic.ColorEncode(
//               variable: 'type',
//               values: [Colors.orange.withOpacity(0.3), Colors.transparent],
//             ),
//           ),
//         ],
//         coord: graphic.PolarCoord(transposed: true, dimCount: 1),
//         axes: [graphic.Defaults.circularAxis, graphic.Defaults.radialAxis],
//       ),
//     );
//   }
// }
