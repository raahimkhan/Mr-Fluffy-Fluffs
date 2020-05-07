import 'dart:async';

// A class which is used for State Management. It uses Streams that hold the data and make it available in different screens

int quan = 0;
class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();
  // final itemController = StreamController<List>.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  List allItems = [];
  List checkoutItem = [];
  int number = 0;

  void addToCart(item) {
    allItems.add(item);
    cartStreamController.sink.add(allItems);
  }

  void addCheckout(item) {
    checkoutItem.add(item);
    cartStreamController.sink.add(checkoutItem);
  }

  void removeCheckout(item) {
    checkoutItem.remove(item);
    cartStreamController.sink.add(checkoutItem);
  }

  void removeFromCart(item) {
    allItems.remove(item);
    cartStreamController.sink.add(allItems);
  }

  // ADDED THESE TWO FUNCTIONS ONLY 

  int updateDItem(item) {
    if (item['number'] == 0) {
      return 0;
    }
    else {
      return item["number"]--;
    }
  }

  int updateDPrice(item) {
    return item['price'] - item['original'];
  }

  int updateAPrice(item) {
    return item['price'] + item['original'];
  }

  int updateAItem(item) {
    return item["number"]++;
  }

  // ONLY THE ABOVE TWO

  int calculate() {
    int sum1 = 0;
    int sum2 = 0;

    allItems.forEach((f) => sum1 += f['price']);


    return sum1 + sum2;

  }

  /// The [dispose] method is used 
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc();

