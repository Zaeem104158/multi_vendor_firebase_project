class ProductDataViewModel {
  String? productName;
  String? productDescription;
  String? mainCategory;
  String? subCategory;
  String? productPrice;
  String? productInstock;
  String? productDiscount;
  String? productSid;
  String? productId;
  int selectQuantity;
  bool? productNew;
  List<String>? productImageFile;

  ProductDataViewModel(
      {this.productName,
      this.productDescription,
      this.mainCategory,
      this.subCategory,
      this.productPrice,
      this.productInstock,
      this.productDiscount,
      this.productSid,
      this.productNew,
      this.productId,
      required this.selectQuantity,
      this.productImageFile});

  void increaseQuentity() {
    selectQuantity++;
  }

  void decreaseQuentity() {
    selectQuantity--;
  }
}
