import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  final _pageController1 = PageController(viewportFraction: 0.8);
  final _pageController2 = PageController(viewportFraction: 0.8);

  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: _onDrag,
        onHorizontalDragEnd: (_) {
          if (!_isDragging) return;

          setState(() {
            _isDragging = false;
          });
        },
        child: Column(
          children: [
            _buildPageView(_pageController1),
            const SizedBox(height: 10),
            _buildPageView(_pageController2),
          ],
        ),
      ),
    );
  }

  List<Widget> _getChildren() {
    return [
      _buildContainer(Colors.red),
      _buildContainer(Colors.green),
      _buildContainer(Colors.grey),
      _buildContainer(Colors.blue),
    ];
  }

  void _onDrag(DragUpdateDetails details) {
    /// how much the user has dragged
    final _dragOffset = details.primaryDelta ?? 0;
    if (!_isDragging) {
      setState(() {
        _isDragging = true;
      });
    }

    /// subtracting the drag offset from the page view's offset
    _pageController1.jumpTo(_pageController1.offset - _dragOffset);
    _pageController2.jumpTo(_pageController2.offset - _dragOffset);
  }

  Widget _buildContainer(Color color) {
    return Container(
      color: color,
      child: const Center(
        child: Text('hello', style: TextStyle(fontSize: 21)),
      ),
    );
  }

  Widget _buildPageView(PageController pageController) {
    return Expanded(
      child: AbsorbPointer(
        child: PageView(
          controller: pageController,
          children: _getChildren(),
          pageSnapping: !_isDragging,
        ),
      ),
    );
  }
}
