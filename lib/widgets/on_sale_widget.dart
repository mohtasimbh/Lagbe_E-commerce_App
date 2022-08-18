import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../consts/firebase_consts.dart';
import '../inner_screens/product_details.dart';
import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import 'price_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FancyShimmerImage(
                        imageUrl: productModel.imageUrl,
                        height: size.width * 0.20,
                        width: size.width * 0.20,
                        boxFit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: productModel.isPiece ? '1Piece' : '1KG',
                            color: color,
                            textSize: 22,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: isInCart
                                    ? null
                                    : () async {
                                        final User? user =
                                            authInstance.currentUser;

                                        if (user == null) {
                                          GlobalMethods.errorDialog(
                                              subtitle:
                                                  'No user found, Please login first',
                                              context: context);
                                          return;
                                        }
                                        await GlobalMethods.addToCart(
                                            productId: productModel.id,
                                            quantity: 1,
                                            context: context);
                                        await cartProvider.fetchCart();
                                        // cartProvider.addProductsToCart(
                                        //     productId: productModel.id,
                                        //     quantity: 1);
                                      },
                                child: Icon(
                                  isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                  size: 22,
                                  color: isInCart ? Colors.green : color,
                                ),
                              ),
                              HeartBTN(
                                productId: productModel.id,
                                isInWishlist: isInWishlist,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PriceWidget(
                    isOnSale: productModel.isOnSale,
                    price: productModel.price,
                    salePrice: productModel.salePrice,
                    textPrice: '1',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: productModel.title,
                    maxLines: 1,
                    color: color,
                    textSize: 20,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
