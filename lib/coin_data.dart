import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC','BNB','doge','shiba inu'];

class CoinData {
  num price;
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=$selectedCurrency&order=market_cap_desc&per_page=100&page=1&sparkline=false";
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        if(crypto=="BTC"){
        price = decodedData[0]['current_price'];
        }else if(crypto=="ETH"){
         price = decodedData[1]['current_price'];
        }else if (crypto=="BNB"){
          price = decodedData[2]['current_price'];
        }else if(crypto=="doge"){
           price = decodedData[9]['current_price'];
        }else if(crypto=="shiba inu"){
          price = decodedData[10]['current_price'];
        }else{
          price = decodedData[13]['current_price'];
        }
        cryptoPrices[crypto] = price.toString();
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
