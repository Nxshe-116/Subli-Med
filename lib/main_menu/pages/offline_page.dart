import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/quote.dart';

class Facts extends StatefulWidget {
  const Facts({Key? key}) : super(key: key);

  @override
  State<Facts> createState() => _VitalsPageState();
}

class _VitalsPageState extends State<Facts> {

  List<Quote> quotes = [
    Quote(author: 'WHO', text: "Soap and water are best in terms of getting rid of bacteria. However, if this isn't practicable, using an alcohol-based hand sanitizer is still very effective. Regular hand washing is highly recommended by the WHO at present, especially to help prevent the spread of the coronavirus."),
    Quote(author: 'Salma', text: "Keeping your skin clean, supple, and well hydrated and very important for good health. Your skin ages as you grow older. Good skin care and good nutrition are important to minimize skin damage. It's important to eat a diet full of antioxidants (fruit and vegetables), to get enough sleep, to use skin protection creams against sun damage, and to keep your skin moisturized."),
    Quote(text: "High levels of sat in the diet can elevate your blood pressure. Higher blood pressure is associated with a reduced life expectancy. Choose low salt options in restaurants and supermarkets. Avoid adding salt to food. Use garlic and herbs instead.", author: 'Otis'),
    Quote(author:'Juliet', text:" Make sure you drink at least 2L (8 glasses) every day. This can be tap water and does not need to be expensive bottled water."),
    Quote(author: 'Keith Mupinda', text: "Increased levels of exercise have been shown to increase life expectancy by 25-30%. Exercise not only benefits the heart, lowers blood pressure and stimulates your metabolism, it releases powerful endorphins which elevate mood and improve well-being. Exercise can be viewed as a drug for longevity"),
    Quote(text: 'Using time productively will enable you to use the day more efficiently.', author: "Mr. Gotora"),
    Quote(text: "Get enough sleep!", author: "Dr. Aneni")
  ];

  Widget quoteTemplate(quote) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        elevation: 5.0,
        color: kPrimaryColor2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                quote.text,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                quote.author,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Facts and Tips",
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
    children: quotes.map((quote) => quoteTemplate(quote)).toList(),
    ),
      ),

    );
  }
}
