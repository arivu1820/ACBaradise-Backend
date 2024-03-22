import 'package:acbaradise/Widgets/SingleWidgets/AnnualACCard.dart';
import 'package:flutter/material.dart';

class AMCCategorySelection extends StatefulWidget {
  final String splitACimg;
  final String windowACimg;
  final String cassetteACimg;
  final VoidCallback fun;// Accept GlobalKey as a parameter
  const AMCCategorySelection({
    this.splitACimg = '',
    this.windowACimg = '',
    this.cassetteACimg = '',
    required this.fun,
  });

  @override
  State<AMCCategorySelection> createState() => _AMCCategorySelectionState();
}

class _AMCCategorySelectionState extends State<AMCCategorySelection> {
  bool issplit = true;
  bool iswindow = false;
  bool iscassette = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  issplit = true;
                  iswindow = false;
                  iscassette = false;
                });
                widget.fun();
              },
              child: AnnualACCard(
                condition: issplit,
                name: "Split AC",
                img: widget.splitACimg,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  issplit = false;
                  iswindow = true;
                  iscassette = false;
                });
                widget.fun();
              },
              child: AnnualACCard(
                condition: iswindow,
                name: "Window AC",
                img: widget.windowACimg,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  issplit = false;
                  iswindow = false;
                  iscassette = true;
                });
                widget.fun();
              },
              child: AnnualACCard(
                condition: iscassette,
                name: "Cassette AC",
                img: widget.cassetteACimg,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
