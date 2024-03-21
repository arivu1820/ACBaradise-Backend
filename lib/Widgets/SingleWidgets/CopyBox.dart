import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:acbaradise/Theme/Colors.dart';

class CopyBox extends StatelessWidget {
  final String id;

  const CopyBox({Key? key, required this.id}) : super(key: key);

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        height: 30,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: lightGray80Color,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "#" + id,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "OxygenRegular",
                    fontSize: 12,
                    color: blackColor,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _copyToClipboard(context);
              },
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: lightGray80Color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "Assets/Icons/Group_88.png",
                      height: 14,
                      width: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Copy",
                      style: TextStyle(
                        fontFamily: "OxygenRegular",
                        fontSize: 12,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
