import 'package:flutter/material.dart';

class PickOfferScreen extends StatefulWidget {
  const PickOfferScreen({Key? key}) : super(key: key);

  @override
  _PickOfferScreenState createState() => _PickOfferScreenState();
}

class _PickOfferScreenState extends State<PickOfferScreen> {
  int? selectedOfferIndex;

  final List<Map<String, dynamic>> offers = [
    {
      'oilType': 'Cooking Oil',
      'quantity': 700,
      'price': 3,
      'distance': 20,
      'image': 'assets/images/cookingOil.png',
    },
    {
      'oilType': 'Motor Oil',
      'quantity': 540,
      'price': 4,
      'distance': 30,
      'image': 'assets/images/motorOil.png',
    },
    {
      'oilType': 'Motor Oil',
      'quantity': 300,
      'price': 5,
      'distance': 40,
      'image': 'assets/images/motorOil.png',
    },
  ];

  void _onChooseOffer() {
    if (selectedOfferIndex != null) {
      final selectedOfferDetails = offers[selectedOfferIndex!];
      Navigator.pop(context, selectedOfferDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: offers.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            itemBuilder: (context, index) {
              final offer = offers[index];
              final finalPrice = offer['quantity'] * offer['price'];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOfferIndex = index;
                  });
                },
                child: Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              offer['image'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer['oilType'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('Quantity: ${offer['quantity']} L'),
                                  Text(
                                      'Price per liter: ${offer['price']} SAR'),
                                  Text('Distance: ${offer['distance']} KM'),
                                ],
                              ),
                            ),
                            Icon(
                              selectedOfferIndex == index
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: selectedOfferIndex == index
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '${finalPrice.toStringAsFixed(2)} SAR',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: selectedOfferIndex != null ? _onChooseOffer : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedOfferIndex != null ? Colors.green : Colors.grey,
              padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'CHOOSE',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
