import 'package:flutter/material.dart';
import 'package:flutter_application_4/dummy_Db.dart';
import 'package:flutter_application_4/view/homescreen/widget/_buillder_card.dart';

class Homescreeen extends StatefulWidget {
  const Homescreeen({super.key});

  @override
  State<Homescreeen> createState() => _HomescreeenState();
}

class _HomescreeenState extends State<Homescreeen> {
  TextEditingController Titlecontroller = TextEditingController();
  TextEditingController Descriptioncontroller = TextEditingController();
  TextEditingController Datecontroller = TextEditingController();
  int selectedcolorindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // to clear controller opening the bottom sheet
          Titlecontroller.clear();
          Descriptioncontroller.clear();
          Datecontroller.clear();
          selectedcolorindex = 0;
          _customBottomsheet(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              ListView.separated(
                  padding: EdgeInsets.all(10),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => BuildCard(
                    buildercolour: DummyDb.containercolor[DummyDb.notelist[index]["colorIndex"]],
                        tittle: DummyDb.notelist[index]["tittle"],
                        date: DummyDb.notelist[index]["date"],
                        dec: DummyDb.notelist[index]["dec"],
                        onDelete: () {
                          DummyDb.notelist.removeAt(index);
                          setState(() {});
                        },
                        onEdit: () {
                          Titlecontroller.text =
                              DummyDb.notelist[index]["tittle"];
                          Datecontroller.text = DummyDb.notelist[index]["date"];
                          Descriptioncontroller.text =
                              DummyDb.notelist[index]["dec"];

                          _customBottomsheet(context,
                              isEdit: true, itemindex: index);
                        },
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                  itemCount: DummyDb.notelist.length),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _customBottomsheet(BuildContext context,
      {bool isEdit = false, int? itemindex}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: Titlecontroller,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Tittle",
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: Descriptioncontroller,
                maxLines: 5,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Description",
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: Datecontroller,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "date",
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              // buildcolour section
              StatefulBuilder(
                builder: (context, setState) => Row(   
                  children: List.generate(
                      DummyDb.containercolor.length,
                      (index) => Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedcolorindex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                    border: selectedcolorindex == index
                                        ? Border.all(width: 4)
                                        : null,
                                    borderRadius: BorderRadius.circular(10),
                                    color: DummyDb.containercolor[index]),
                              ),
                            ),
                          )),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (isEdit == true) {
                          DummyDb.notelist[itemindex!] = {
                            "tittle": Titlecontroller.text,
                            "dec": Descriptioncontroller.text,
                            "date": Datecontroller.text,
                            "colorIndex": selectedcolorindex
                          };
                        } else
                          DummyDb.notelist.add({
                            "tittle": Titlecontroller.text,
                            "dec": Descriptioncontroller.text,
                            "date": Datecontroller.text,
                            "colorIndex": selectedcolorindex
                          });
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(isEdit ? "update" : "Save"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Cancel"),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
