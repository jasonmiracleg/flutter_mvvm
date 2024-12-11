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

  dynamic selectedOriginProvince;
  dynamic selectedDestinationProvince;
  dynamic selectedOriginCity;
  dynamic selectedDestinationCity;
  dynamic weight;
  List<String> couriers = ['jne', 'pos', 'tiki'];
  dynamic selectedCourier = 'jne';

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
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: DropdownButton<String>(
                    value: selectedCourier,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCourier = newValue;
                      });
                    },
                    items:
                        couriers.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Weight (Kg)',
                    ),
                    onChanged: (value) {
                      setState(() {
                        weight = double.tryParse(value);
                      });
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Origin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Consumer<HomeViewmodel>(builder: (context, value, _) {
                    switch (value.provinceList.status) {
                      case Status.loading:
                        return const Align(
                          alignment: Alignment.center,
                          child: Text("Pilih Provinsi"),
                        );
                      case Status.error:
                        return Align(
                            alignment: Alignment.center,
                            child: Text(value.provinceList.message.toString()));
                      case Status.completed:
                        return DropdownButton(
                            isExpanded: true,
                            value: selectedOriginProvince,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 30,
                            elevation: 2,
                            hint: selectedOriginProvince == null
                                ? const Text('Pilih Provinsi')
                                : Text(selectedOriginProvince.province),
                            style: const TextStyle(color: Colors.black),
                            items: value.provinceList.data!
                                .map<DropdownMenuItem<Province>>(
                                    (Province value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(value.province.toString()));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedOriginProvince = newValue;
                                selectedOriginCity = null;
                                homeViewmodel.getOriginCityList(
                                    selectedOriginProvince.provinceId);
                              });
                            });
                      default:
                    }
                    return Container();
                  }),
                ),
                const SizedBox(width: 16),
                Expanded(child:
                    Consumer<HomeViewmodel>(builder: (context, value, _) {
                  switch (value.originCityList.status) {
                    case Status.loading:
                      return const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    case Status.error:
                      return Align(
                          alignment: Alignment.topLeft,
                          child: Text(value.originCityList.message.toString()));
                    case Status.completed:
                      return DropdownButton(
                          isExpanded: true,
                          value: selectedOriginCity,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          elevation: 2,
                          hint: selectedOriginCity == null
                              ? const Text('Pilih Kota')
                              : Text(selectedOriginCity.cityName),
                          style: const TextStyle(color: Colors.black),
                          items: value.originCityList.data!
                              .map<DropdownMenuItem<City>>((City value) {
                            return DropdownMenuItem(
                                value: value,
                                child: Text(value.cityName.toString()));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedOriginCity = newValue;
                            });
                          });
                    default:
                  }
                  return Container();
                }))
              ],
            ),
            const SizedBox(
              height: 24,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Destination",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Consumer<HomeViewmodel>(builder: (context, value, _) {
                    switch (value.provinceList.status) {
                      case Status.loading:
                        return const Align(
                          alignment: Alignment.center,
                          child: Text("Pilih Provinsi"),
                        );
                      case Status.error:
                        return Align(
                            alignment: Alignment.center,
                            child: Text(value.provinceList.message.toString()));
                      case Status.completed:
                        return DropdownButton(
                            isExpanded: true,
                            value: selectedDestinationProvince,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 30,
                            elevation: 2,
                            hint: selectedDestinationProvince == null
                                ? const Text('Pilih Provinsi')
                                : Text(selectedDestinationProvince.province),
                            style: const TextStyle(color: Colors.black),
                            items: value.provinceList.data!
                                .map<DropdownMenuItem<Province>>(
                                    (Province value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(value.province.toString()));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedDestinationProvince = newValue;
                                selectedDestinationCity = null;
                                homeViewmodel.getDestinationCityList(
                                    selectedDestinationProvince.provinceId);
                              });
                            });
                      default:
                    }
                    return Container();
                  }),
                ),
                const SizedBox(width: 16),
                Expanded(child:
                    Consumer<HomeViewmodel>(builder: (context, value, _) {
                  switch (value.destinationCityList.status) {
                    case Status.loading:
                      return const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    case Status.error:
                      return Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              value.destinationCityList.message.toString()));
                    case Status.completed:
                      return DropdownButton(
                          isExpanded: true,
                          value: selectedDestinationCity,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          elevation: 2,
                          hint: selectedDestinationCity == null
                              ? const Text('Pilih Kota')
                              : Text(selectedDestinationCity.cityName),
                          style: const TextStyle(color: Colors.black),
                          items: value.destinationCityList.data!
                              .map<DropdownMenuItem<City>>((City value) {
                            return DropdownMenuItem(
                                value: value,
                                child: Text(value.cityName.toString()));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedDestinationCity = newValue;
                            });
                          });
                    default:
                  }
                  return Container();
                }))
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
              ),
              onPressed: () {
                if (validateInput()) {
                  homeViewmodel.calculateCourierCost(
                      origin: selectedOriginCity.cityId.toString(),
                      destination: selectedDestinationCity.cityId.toString(),
                      weight: weight.toInt(),
                      courier: selectedCourier);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please fill in all required fields!',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                "Hitung Estimasi Harga",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  Consumer<HomeViewmodel>(builder: (context, viewModel, child) {
                final courierCostState = viewModel.courierCost;

                // Check if loading
                if (courierCostState.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Handle success (completed state)
                else if (courierCostState.status == Status.completed) {
                  // Get the courier data from the response
                  final courier = courierCostState.data;

                  // Check if courier data is available and not null
                  if (courier!.costs != null) {
                    return ListView(
                      children: [
                        ...courier.costs?.map((costItem) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      height:
                                          8), // Add spacing after the courier name
                                  ...courier.costs?.map((costItem) {
                                        return Card(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  costItem.service ??
                                                      "Unknown Service",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueAccent,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  costItem.description ??
                                                      "No description",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                ...costItem.cost?.map((cost) {
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            leading: const Icon(
                                                              Icons
                                                                  .monetization_on,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                            title: Text(
                                                              cost.note ??
                                                                  "No note",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            subtitle: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Cost: ${cost.value?.toString() ?? "0"} IDR",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                                Text(
                                                                  "ETD: ${cost.etd ?? "N/A"} days",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(), // Separate multiple costs for the same service
                                                        ],
                                                      );
                                                    }).toList() ??
                                                    [],
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList() ??
                                      [],
                                ],
                              );
                            }).toList() ??
                            [],
                      ],
                    );
                  } else {
                    return const Text("No courier data available.");
                  }
                } else if (courierCostState.status == Status.error) {
                  return Text("Error: ${courierCostState.message}");
                } else {
                  return const Text(
                      "Press the button to calculate courier cost.");
                }
              }),
            ),
          ]),
        ),
      ),
    );
  }

  bool validateInput() {
    return selectedOriginCity != null &&
        selectedDestinationCity != null &&
        weight != null &&
        selectedCourier != null;
  }
}
