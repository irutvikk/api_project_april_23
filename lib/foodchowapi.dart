import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Foodchowpage extends StatelessWidget {
   Foodapi fd = Get.put(Foodapi(),);
  TextEditingController search = TextEditingController();
  List ll=["Sort By","Services","Great Offeres"];
  @override
  Widget build(BuildContext context) {
    fd.fetchdata();
    return Scaffold(
      appBar: AppBar(
        title: Text("FOOD CHOW"),
        centerTitle: true,
      ),
      body: Column(
        children: [
      Card(
      color: Colors.blue.shade50,
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
            SizedBox(
              height: 45,
              child: TextField(
              controller: search,
              decoration: InputDecoration(
                hintText: "Search Restaurant Name",
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ),
            ),
          SizedBox(
            height: 10,
          ),
              Container(
                height: 45,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ll.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('   ${ll[index]}   ')),
                    );
                  }
                ),
              ),
            ],
        ),
      ),
      ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: fd.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          color: Colors.grey.shade300,
                        ),
                        height: 250,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                              flex:6,
                              child: Center(child: Text("${fd.data.value}",),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(

                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
      ],
    ),
    );
  }
}

class Foodapi extends GetxController {
  var data = {}.obs;

  Future<void> fetchdata() async {
    var response = await http.get(Uri.parse('https://www.foodchow.com/api/FoodChowWD/AllRestaurantsWDOfferApp?Country=India&city=Surat&area=&longitude=&latitude=&deliveryMethod=&cuisineId=2,1&clientid=&startlimit=0&endlimit=1000&onoffflag'));
    data.value = jsonDecode(response.body) as Map;
    print("data value=====${data.value}=====");
  }

}

