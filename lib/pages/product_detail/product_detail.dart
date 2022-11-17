import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/cart_provider.dart';
import '../../models/product.dart';
import '../../theme.dart';
import 'components/filled_icon.dart';

class ProductDetail extends StatefulWidget {
  final Product prod;
  const ProductDetail({
    Key? key,
    required this.prod,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late final ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            bottom: -MediaQuery.of(context).size.height * 0.1,
            left: -MediaQuery.of(context).size.width * 0.3,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.lightColor.withOpacity(0.4),
                )),
          ),
          _buildBody(),
        ],
      )),
      floatingActionButton: _buildFab(),
      extendBodyBehindAppBar: true,
    );
  }

  _buildBody() => CustomScrollView(slivers: <Widget>[
        _buildSliverAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Text(
                widget.prod.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.prod.rating}",
                      style: const TextStyle(
                        color: Color(0xff333333),
                        fontSize: 20.0,
                      ),
                    ),
                    FilledIcon(prodRating: widget.prod.rating),
                    const Spacer(),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColor.lightColor,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.prod.description,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ]);

  _buildSliverAppBar() => SliverAppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.buttonColor,
            size: 24.0,
          ),
        ),
        pinned: true,
        expandedHeight: MediaQuery.of(context).size.height * 0.4,
        flexibleSpace: Stack(alignment: Alignment.center, children: [
          Hero(
            //evito di dare lo stesso tag alle stesse immagini delle varie liste
            tag: "${widget.prod.rating >= 4.7}_${widget.prod.id}",
            child: _buildProductImages(),
          ),
          Positioned(
            left: 0.0,
            right: MediaQuery.of(context).size.width * 0.9,
            top: MediaQuery.of(context).size.height * 0.25,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_left,
                size: 24.0,
              ),
              color: AppColor.buttonColor,
              onPressed: () {
                //!scrolla di una posizione a sinistra
                _controller.animateTo(
                  _controller.offset - MediaQuery.of(context).size.width,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.9,
            right: 0.0,
            top: MediaQuery.of(context).size.height * 0.25,
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_right,
                  size: 24.0,
                ),
                color: AppColor.buttonColor,
                onPressed: () {
                  _controller.animateTo(
                      _controller.offset + MediaQuery.of(context).size.width,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn);
                  //!scrolla di una posizione a destra
                },
              ),
            ),
          ),
        ]),
      );

  ListView _buildProductImages() {
    List images = widget.prod.images;
    //images.insert(0, prod.thumbnail); ho notato che il thumbnail è l'ultima immagine nella lista, quindi basta rovesciarla (aggiungo images.reversed)
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      controller: _controller,
      children: images.reversed
          .map(
            (e) => Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(e as String),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  _buildFab() => Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "\$ ${widget.prod.price}",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              child: const Text("Add to Cart"),
              onPressed: () {
                context.read<CartProvider>().addItem(widget.prod);
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(SnackBar(
                    duration: const Duration(milliseconds: 1200),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text("Succesfully Added to Cart !"),
                        ]),
                  ));
              },
            ),
          ),
        ],
      );
}
