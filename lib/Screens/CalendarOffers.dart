import 'package:first_proyect/model/DiscountProducts.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:first_proyect/Colors App/Constants.dart';

class CalendarOffers extends StatefulWidget {
  CalendarOffers({Key? key}) : super(key: key);
  @override
  State<CalendarOffers> createState() => _CalendarOffersState();
}

class _CalendarOffersState extends State<CalendarOffers> {
  DateTime finalYearCalendar = DateTime.utc(2030, 01, 01);

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<DiscountProduct> discountProducts = [];

  @override
  void initState() {
    super.initState();
    calculateFinalYear();
    readLS();
  }

  void calculateFinalYear() {
    if (finalYearCalendar.year == finalYearCalendar.year - 5) {
      finalYearCalendar.year + 10;
    }
  }

  Future<void> readLS() async {
    final items = await Localstore.instance.collection("discounts").get();
    for (var entry in items!.entries) {
      var discount = DiscountProduct.fromJson(entry.value);
      discountProducts.add(discount);
    }
  }

  List<Product> calendarProducts = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(top: 5, left: 10, right: 20, bottom: 20),
          child: TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left),
              rightChevronIcon: Icon(Icons.chevron_right),
              titleTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            focusedDay: focusedDay,
            firstDay: DateTime.utc(2005, 01, 01),
            lastDay: finalYearCalendar,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (dateProducts() != 0) {
                  var discounts = dateProducts().toString();
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 14,
                      height: 14,
                      alignment: Alignment.center,
                      child: Text(
                        discounts,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(190, 140, 99, 0.3),
                      ),
                    ),
                  );
                } else {
                  return null;
                }
              },
            ),

            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              todayTextStyle: const TextStyle(
                color: textButtonColor,
              ),
              selectedDecoration: BoxDecoration(
                color: secundaryColor.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(
                color: textButtonColor,
              ),
              todayDecoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              defaultDecoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              weekendDecoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            locale: 'en_ES', //'en_US'
          ),
        ),
      ]),
    );
  }

  int dateProducts() {
    int count = 0;
    for (int i = 0; i < discountProducts.length; i++) {
      if (discountProducts[i].discountStartDate.day == selectedDay.day) {
        count++;
      }
    }
    return count;
  }
}
