import 'package:flutter/material.dart';
import 'package:flutter_application_4/utils/color_Constants.dart';
import 'package:share_plus/share_plus.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.tittle, required this.dec, required this.date, required this.buildercolour});
  final String tittle;
  final String dec;
  final String date;
  final Color buildercolour;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstants.BLACK,
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tittle,
                      style: TextStyle(
                          color: ColorConstants.BLACK,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dec,
                      style: TextStyle(
                        color: ColorConstants.BLACK,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                              color: ColorConstants.BLACK,
                              fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            //share text
                            Share.share('$tittle \n $dec \n $date');
                          },
                          icon: Icon(
                            Icons.share,
                            color: ColorConstants.BLACK,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color:buildercolour,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
