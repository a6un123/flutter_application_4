import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class BuildCard extends StatelessWidget {
  const BuildCard({super.key, this.onDelete, required this.tittle, required this.dec, required this.date, this.onEdit, required this.buildercolour});
  final void Function()? onDelete;
  final void Function()? onEdit;
  final String tittle;
  final String dec;
  final String date;
  final Color buildercolour;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:buildercolour),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(tittle,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Spacer(),
                InkWell(
                  onTap: onEdit,
                  child: Icon(Icons.edit)),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: onDelete,
                  child: Icon(Icons.delete))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(dec,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  date,
                  style:
                      TextStyle( fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Share.share('$tittle \n$date \n$dec');
                  },
                  child: Icon(Icons.share))
              ],
            )
          ],
        ),
      ),
    );
  }
}
