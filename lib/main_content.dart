import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget {
  int _selectedIndex = 1;
  MyStatefulPageView _myStatefulPageView;
  MyStatefulBottomNavigationBar _myStatefulBottomNavigationBar;

  void _onItemTapped(int index) {
    _myStatefulPageView.setPage(index);
    //_pageView.controller.animateToPage(_selectedIndex,duration: Duration(milliseconds: 300),curve: Curves.decelerate);
  }

  void _onPageSelected(int page){
    _myStatefulBottomNavigationBar.setItem(page);
  }

  @override
  Widget build(BuildContext context) {
    _myStatefulPageView = MyStatefulPageView(onPageSelected: _onPageSelected,selectedIndex: _selectedIndex,);
    _myStatefulBottomNavigationBar = MyStatefulBottomNavigationBar(onItemTapped: _onItemTapped,selectedIndex: _selectedIndex,);
    return Scaffold(
      body: _myStatefulPageView,
      bottomNavigationBar: _myStatefulBottomNavigationBar,
    );
  }
}

class MyStatefulPageView extends StatefulWidget {
  MyStatefulPageView({Key key, this.selectedIndex: 0, @required this.onPageSelected}) : super(key: key);

  final int selectedIndex;
  final ValueChanged<int> onPageSelected;

  _MyStatefulPageViewState _myStatefulPageViewState;

  void setPage(int page){
    _myStatefulPageViewState.setPage(page);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _myStatefulPageViewState = _MyStatefulPageViewState(pageSelected: selectedIndex);
    return _myStatefulPageViewState;
  }


}

class _MyStatefulPageViewState extends State<MyStatefulPageView>{
  _MyStatefulPageViewState({this.pageSelected: 0});
  int pageSelected;
  PageView _pageView;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Index 0: Home',
        style: optionStyle,
      ),
    ),
    Center(
      child: Text(
        'Index 1: Business',
        style: optionStyle,
      ),
    ),
    Center(
      child: Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ),
  ];

  void setPage(int page){
    _pageView.controller.animateToPage(page,duration: Duration(milliseconds: 300),curve: Curves.decelerate);
  }

  void _onPageChanged(int page){
    setState(() {
      pageSelected = page;
    });
    widget.onPageSelected(page);
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _pageView = PageView(
      controller: PageController(initialPage: pageSelected),
      children: _widgetOptions,
      onPageChanged: _onPageChanged,
    );
    return _pageView;
  }
}

class MyStatefulBottomNavigationBar extends StatefulWidget {
  MyStatefulBottomNavigationBar({Key key, this.selectedIndex: 0, @required this.onItemTapped}) : super(key: key);

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  _MyStatefulBottomNavigationBarState _myStatefulBottomNavigationBarState;

  void setItem(int index){
    _myStatefulBottomNavigationBarState.setIndex(index);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _myStatefulBottomNavigationBarState  = _MyStatefulBottomNavigationBarState(selectedIndex: selectedIndex);
    return _myStatefulBottomNavigationBarState;
  }
}

class _MyStatefulBottomNavigationBarState extends State<MyStatefulBottomNavigationBar>{
  _MyStatefulBottomNavigationBarState({this.selectedIndex: 0});

  int selectedIndex;

  void setIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  void _handleTap(int index){
    setState(() {
      selectedIndex = index;
    });
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('School'),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _handleTap,
    );
  }

}