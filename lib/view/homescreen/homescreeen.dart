import 'package:flutter/material.dart';
import 'package:flutter_application_4/dummy_Db.dart';
import 'package:flutter_application_4/utils/app_section.dart';
import 'package:flutter_application_4/view/detailsscreen/details_screen.dart';
import 'package:flutter_application_4/view/homescreen/widget/_buillder_card.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

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
  var noteBox = Hive.box(AppSection.NOTEBOX); //step2 reffernce

  List notekeys = [];
  @override
  void initState() {
    notekeys = noteBox.keys.toList();
    setState(() {});
    super.initState();
  }

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
                  itemBuilder: (context, index) {
                    var currentNote = noteBox.get(notekeys[index]);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  tittle: currentNote["tittle"],
                                  dec: currentNote["dec"],
                                  date: currentNote["date"],
                                  buildercolour: DummyDb.containercolor[
                                      currentNote["colorIndex"]]),
                            ));
                      },
                      child: BuildCard(
                        buildercolour:
                            DummyDb.containercolor[currentNote["colorIndex"]],
                        tittle: currentNote["tittle"],
                        date: currentNote["date"],
                        dec: currentNote["dec"],
                        onDelete: () {
                          noteBox.delete(notekeys[index]);
                          notekeys = noteBox.keys.toList();
                          setState(() {});
                        },
                        onEdit: () {
                          Titlecontroller.text = currentNote["tittle"];
                          Datecontroller.text = currentNote["date"];
                          Descriptioncontroller.text = currentNote["dec"];
                          selectedcolorindex = currentNote["colorIndex"];

                          _customBottomsheet(context,
                              isEdit: true, itemindex: index);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                  itemCount: notekeys.length),
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
                readOnly: true,
                controller: Datecontroller,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "date",
                    suffixIcon: IconButton(
                        onPressed: () async {
                          var selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now());
                          if (selectedDate != null) {
                            Datecontroller.text =
                                DateFormat("dd/MMM/yy").format(selectedDate);
                          }
                        },
                        icon: Icon(Icons.calendar_month_outlined)),
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
                          noteBox.put(notekeys[itemindex!], {
                            "tittle": Titlecontroller.text,
                            "dec": Descriptioncontroller.text,
                            "date": Datecontroller.text,
                            "colorIndex": selectedcolorindex
                          });
                          // DummyDb.notelist[itemindex!] = {
                          //   "tittle": Titlecontroller.text,
                          //   "dec": Descriptioncontroller.text,
                          //   "date": Datecontroller.text,
                          //   "colorIndex": selectedcolorindex
                          // };
                        } else
                          //step 3 data add
                          noteBox.add({
                            "tittle": Titlecontroller.text,
                            "dec": Descriptioncontroller.text,
                            "date": Datecontroller.text,
                            "colorIndex": selectedcolorindex
                          });
                        notekeys = noteBox.keys.toList();
                        Navigator.pop(context);
                        setState(() {});
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
