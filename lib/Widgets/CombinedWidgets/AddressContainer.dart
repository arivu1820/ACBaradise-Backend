import 'package:acbaradise/Widgets/SingleWidgets/RadioBtn.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';

class AddressContainer extends StatelessWidget {
  final String Address;
  final String Contact;
  final bool isSelected;
  final VoidCallback onDelete;

  AddressContainer({
    required this.Address,
    required this.Contact,
    required this.isSelected,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: lightBlueColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioBtn(isselected: isSelected),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '$Address\n',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "LexendRegular",
                    color: blackColor,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: '\nContact: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "LexendRegular",
                        color: blackColor,
                      ),
                    ),
                    const TextSpan(
                      text: '+91 ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "LexendLight",
                        color: blackColor,
                      ),
                    ),
                    TextSpan(
                      text: Contact,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "LexendLight",
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Remove Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "LexendMedium",
                          color: blackColor,
                        ),
                      ),
                      content: const Text(
                        'Are you sure you want to remove your address details? This action cannot be undone.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "LexendRegular",
                          color: blackColor,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "LexendRegular",
                                color: darkBlueColor,
                              )),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Remove',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "LexendRegular",
                                color: darkBlueColor,
                              )),
                          onPressed: () {
                            onDelete();
                            Navigator.of(context).pop();
                            // Handle the confirm action
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Image.asset(
                "Assets/Icons/Close_Cross_Icon.png",
                width: 19,
                height: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
