// import 'package:flutter/material.dart';

// class ViewScreen extends StatefulWidget {
//   const ViewScreen({super.key});

//   @override
//   State<ViewScreen> createState() => _ViewScreenState();
// }

// class _ViewScreenState extends State<ViewScreen>
//     with SingleTickerProviderStateMixin {
//   bool _showFloating = false;
//   late AnimationController _controller;
//   late Animation<double> _widthAnim;
//   late Animation<double> _opacityAnim;

//   static const double minWidth = 80;
//   static const double shadowStartWidth = 90;
//   static const double maxWidth = 300;
//   static const double maxShadow = 20;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );
//     _widthAnim = Tween<double>(
//       begin: minWidth,
//       end: maxWidth,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//     _opacityAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
//       CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3)),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _toggleFloating() async {
//     if (!_showFloating) {
//       setState(() {
//         _showFloating = true;
//       });
//       await _controller.forward();
//     } else {
//       await _controller.reverse();
//       setState(() {
//         _showFloating = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('View')),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: GestureDetector(
//                 onTap: _toggleFloating,
//                 child: !_showFloating
//                     ? AnimatedBuilder(
//                         animation: _opacityAnim,
//                         builder: (context, child) {
//                           return Opacity(
//                             opacity: _opacityAnim.value,
//                             child: Container(
//                               height: 700,
//                               width: minWidth,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(24),
//                                 color: Colors.deepPurple,
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: List.generate(4, (i) {
//                                   final List<IconData> icons = [
//                                     Icons.home,
//                                     Icons.person,
//                                     Icons.notifications,
//                                     Icons.settings,
//                                   ];
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       vertical: 12.0,
//                                     ),
//                                     child: Container(
//                                       width: 48,
//                                       height: 48,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.12),
//                                         borderRadius: BorderRadius.circular(16),
//                                       ),
//                                       child: Icon(
//                                         icons[i],
//                                         color: Colors.white,
//                                         size: 28,
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                     : const SizedBox.shrink(),
//               ),
//             ),
//           ),
//           if (_showFloating)
//             Stack(
//               children: [
//                 Positioned.fill(
//                   child: GestureDetector(
//                     behavior: HitTestBehavior.translucent,
//                     onTap: () async {
//                       await _controller.reverse();
//                       setState(() {
//                         _showFloating = false;
//                       });
//                     },
//                     child: const SizedBox.expand(),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Material(
//                     color: Colors.transparent,
//                     elevation: 0,
//                     borderRadius: BorderRadius.circular(24),
//                     child: AnimatedBuilder(
//                       animation: _widthAnim,
//                       builder: (context, child) {
//                         final double width = _widthAnim.value;
//                         double shadow = 0;
//                         if (width > shadowStartWidth) {
//                           final double t =
//                               ((width - shadowStartWidth) /
//                                       (maxWidth - shadowStartWidth))
//                                   .clamp(0.0, 1.0);
//                           shadow = t * maxShadow;
//                         }
//                         final List<IconData> icons = [
//                           Icons.home,
//                           Icons.person,
//                           Icons.notifications,
//                           Icons.settings,
//                         ];
//                         final List<String> titles = [
//                           'Home Screen',
//                           'Profile Screen',
//                           'Alerts Screen',
//                           'Settings Screen',
//                         ];

//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 700,
//                             width: width,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(24),
//                               color: Colors.deepPurple,
//                               boxShadow: shadow > 0
//                                   ? [
//                                       BoxShadow(
//                                         color: Colors.black26.withOpacity(
//                                           shadow / maxShadow * 0.7,
//                                         ),
//                                         blurRadius: shadow,
//                                         offset: Offset(0, shadow * 0.4),
//                                       ),
//                                     ]
//                                   : [],
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: List.generate(4, (i) {
//                                 double t =
//                                     ((width - minWidth) / (maxWidth - minWidth))
//                                         .clamp(0.0, 1.0);
//                                 final showTitle = width > minWidth + 8;
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 12.0,
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         width: 80,
//                                         child: Center(
//                                           child: Container(
//                                             width: 48,
//                                             height: 48,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white.withOpacity(
//                                                 0.12,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(16),
//                                             ),
//                                             child: Icon(
//                                               icons[i],
//                                               color: Colors.white,
//                                               size: 28,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       // Title area: fade/slide in/out, smooth fade only
//                                       if (showTitle)
//                                         Expanded(
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 16.0,
//                                             ),
//                                             child: Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Opacity(
//                                                 opacity:
//                                                     t, // t goes from 0 (min width) to 1 (max width)
//                                                 child: Text(
//                                                   titles[i],
//                                                   maxLines: 1,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .titleMedium
//                                                       ?.copyWith(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 );
//                               }),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
