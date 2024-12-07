part of 'pages.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  HomeViewmodel homeViewmodel = HomeViewmodel();

  @override
  void initState() {
    homeViewmodel.getProvinceList();
    super.initState();
  }

  dynamic selectedProvince;
  dynamic selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Calculate Cost"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewmodel>(
        create: (context) => homeViewmodel,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Dropdown Province
                            Consumer<HomeViewmodel>(
                                builder: (context, value, _) {
                              switch (value.provinceList.status) {
                                case Status.loading:
                                  return const Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  );
                                case Status.error:
                                  return Align(
                                      alignment: Alignment.center,
                                      child: Text(value.provinceList.message
                                          .toString()));
                                case Status.completed:
                                  return DropdownButton(
                                      isExpanded: true,
                                      value: selectedProvince,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 2,
                                      hint: selectedProvince == null
                                          ? const Text('Pilih Provinsi')
                                          : Text(selectedProvince.province),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      items: value.provinceList.data!
                                          .map<DropdownMenuItem<Province>>(
                                              (Province value) {
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                                value.province.toString()));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedProvince = newValue;
                                          selectedCity = null;
                                          homeViewmodel.getCityList(
                                              selectedProvince.provinceId);
                                        });
                                      });
                                default:
                              }
                              return Container();
                            }),

                            const Divider(
                              height: 16,
                            ),

                            // Dropdown City
                            Consumer<HomeViewmodel>(
                                builder: (context, value, _) {
                              switch (value.cityList.status) {
                                case Status.loading:
                                  return const Align(
                                    alignment: Alignment.center,
                                    child: Text('Pilih Provinsi Dulu'),
                                  );
                                case Status.error:
                                  return Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          value.cityList.message.toString()));
                                case Status.completed:
                                  return DropdownButton(
                                      isExpanded: true,
                                      value: selectedCity,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 2,
                                      hint: selectedCity == null
                                          ? const Text('Pilih Kota')
                                          : Text(selectedCity.cityName),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      items: value.cityList.data!
                                          .map<DropdownMenuItem<City>>(
                                              (City value) {
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                                value.cityName.toString()));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCity = newValue;
                                          homeViewmodel
                                              .getCityList(selectedCity.cityId);
                                        });
                                      });
                                default:
                              }
                              return Container();
                            })
                          ],
                        ),
                      ))),
              Flexible(flex: 2, child: Container(color: Colors.yellow))
            ],
          ),
        ),
      ),
    );
  }
}
