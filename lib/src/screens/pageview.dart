import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  final _pageController1 = PageController();
  final _pageController2 = PageController();

  bool _isAnimating = false;

  late double _width;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // _listenToControllers(
      //     animator: _pageController1, toBeAnimated: _pageController2);
      // _listenToControllers(
      //     animator: _pageController2, toBeAnimated: _pageController1);
      final _size = MediaQuery.of(context).size;
      _width = _size.width;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: _onDrag,
        child: AbsorbPointer(
          child: RotatedBox(
            quarterTurns: 2,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController1,
                    children: _getChildren(),
                    pageSnapping: true,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: PageView(
                    controller: _pageController2,
                    children: _getChildren(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getChildren() {
    final _size = MediaQuery.of(context).size;

    return [
      Container(
        width: _size.width * 0.8,
        height: _size.height * 0.3,
        color: Colors.red,
      ),
      Container(
        width: _size.width * 0.8,
        height: _size.height * 0.3,
        color: Colors.green,
      ),
    ];
  }

  void _listenToControllers(
      {required PageController animator,
      required PageController toBeAnimated}) {
    animator.addListener(() async {
      if (_isAnimating) {
        return;
      }

      setState(() {
        _isAnimating = true;
      });


      toBeAnimated.jumpTo(animator.offset);

      setState(() {
        _isAnimating = false;
      });
    });
  }

  void _onDrag(DragUpdateDetails details) {
    final _dragOffset = details.localPosition.dx;
    print(_dragOffset);

    _pageController1.jumpTo(_dragOffset);
    _pageController2.jumpTo(_dragOffset);
  }
}
