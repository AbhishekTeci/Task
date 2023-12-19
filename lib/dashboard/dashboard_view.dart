import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_bloc_pattern/dashboard/profile_data_widgets.dart';
import 'package:my_bloc_pattern/dashboard/serach_widgets.dart';
import 'package:my_bloc_pattern/models/employee_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Data> userDataList = [];
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.85,
                child: ListView.builder(
                    itemCount: userDataList.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return EmployeeProfile(
                        name: userDataList[index].employeeName,
                        age: userDataList[index].employeeAge.toString(),
                        image: userDataList[index].profileImage,
                        salary: userDataList[index].employeeSalary.toString(),
                      );
                    }),
              ),
              SearchWidgetView(
                onChanged: (value) {
                  controller.text = value;
                  searchByName(value);
                },
                txtController: controller,
                onSubmitted: (value) {
                  controller.text = value;
                  searchByName(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    const String apiUrl = 'https://dummy.restapiexample.com/api/v1/employees';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String property1Value = data['status'];
        final EmployeeModel dataModel = EmployeeModel.fromJson(data);

        List<Data> items = [];

        List mainList = data['data'];

        //mainList.map((data) => EmployeeModel.fromJson(data)).toList();
        items.addAll(mainList.map((data) => Data.fromJson(data)).toList());
        setState(() {
          userDataList.addAll(items);
        });

        debugPrint(userDataList.length.toString());
        debugPrint('name ${userDataList[0].employeeName}');
        debugPrint("status $property1Value");
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void searchByName(String name) {
    for (int i = 0; i < userDataList.length; i++) {
      if (name == userDataList[i].employeeName) {
        setState(() {
          userDataList.clear();
          userDataList.add(userDataList[i]);
        });
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
}
