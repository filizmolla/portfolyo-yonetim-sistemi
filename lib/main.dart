import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Sidebar(),
            Expanded(
              child: Center(
                child: Text("Main Content Area"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF060606),
      width: 300,
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(30, 100, 46, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),

            ExpandTab(
              text: 'Projects',
              textColor: Color(0xFFF1F1F1),
              backgroundColor: Colors.transparent,
              onTap: () {
                print('Projects tapped');
              },
            ),
            ExpandTab(
              text: 'Tasks',
              textColor: Color(0xFFF1F1F1),
              backgroundColor: Colors.transparent,
              onTap: () {
                print('Tasks tapped');
              },
            ),
            ExpandTab(
              text: 'Dashboard',
              textColor: Color(0xFFF1F1F1),
              backgroundColor: Colors.transparent,
              onTap: () {
                print('Dashboard tapped');
              },
            ),
            ExpandTab(
              text: 'Time log',
              textColor: Color(0xFFF1F1F1),
              backgroundColor: Colors.transparent,
              onTap: () {
                print('Time log tapped');
              },
            ),
            ExpandTab(
              text: 'Resource mgnt',
              textColor: Color(0xFFF1F1F1),
              backgroundColor: Colors.transparent,
              onTap: () {
                print('Resource mgnt tapped');
              },
            ),
            ExpandTab(
              text: 'Users',
              textColor: Color(0xFFF1F1F1),
              backgroundColor: Colors.transparent,
              onTap: () {
                print('Users tapped');
              },
            ),
            ExpandTab(
              text: 'Project template',
              textColor: Color(0xFFF1F1F1),
              backgroundColor: Colors.transparent,
              onTap: () {
                print('Project template tapped');
              },
            ),
            ExpandTab(
              text: 'Menu settings',
              textColor: Color(0xFFF1F1F1),
              backgroundColor: Colors.transparent,
              onTap: () {
                print('Menu settings tapped');
              },
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color frameColor;
  final VoidCallback onTap;

  MenuButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.frameColor,
    required this.onTap,
  });

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: _isHovered ? widget.backgroundColor : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: _isHovered ? widget.frameColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: _isHovered ? widget.textColor : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                widget.text,
                style: TextStyle(
                  color: _isHovered ? widget.textColor : Colors.white,
                  fontSize: 14,
                  fontFamily: 'Aeonik Pro TRIAL-Regular',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandTab extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  ExpandTab({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  _ExpandTabState createState() => _ExpandTabState();
}

class _ExpandTabState extends State<ExpandTab> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.white : widget.backgroundColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: _isHovered ? Color(0xFFE65F2B) : widget.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: _isHovered ? Color(0xFFE65F2B) : widget.textColor,
                    fontSize: 14,
                    fontFamily: 'Aeonik Pro TRIAL-Regular',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
