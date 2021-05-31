import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'makeUp.dart';

class MakeUpProvider with ChangeNotifier {
  List<MakeUp> _makeUpItems = [
    // MakeUp(
    //   prodType: 'Blush',
    //   id: '1',
    //   prodName: 'Multi Purpose Powder - Blush & Eye',
    //   prodBrand: 'rejuva minerals',
    //   desc:
    //       'ur Multi Purpose Pressed Powders may be used for blush or eye shadow. Blended with antioxidants from Certified Organic Fruits, Berries &amp; Botanicals*. Made without any gluten containing ingredients. Mica free Pink Parfait and Papaya will offer a natural, ultra sheer semi-matte finish. The petals from beautiful crushed red roses that are found in Pink Parfait, are valued for their natural color and delightful aroma that they provide! Acai Berry will offer a natural, ultra sheer satin finish (mica added). VEGAN. Image one is Pink Parfait. Image two is Papaya, and image three is Acai Berry. Model in image four is wearing Papaya. Model in image five is wearing Acai Berry. To see a demonstration of Papaya, click on the video and fast forward to 3:44. Enjoy! This product is EWG VERIFIED&#x2122; and rated CLEAN in the Think Dirty app! BPA and Phthalate free packaging. Plastic parts of compacts are recyclable. *Tiny flecks of fruit and botanical particles may be visible in powder. Pink Parfait and Papaya are Titanium Dioxide and Mica free. Net Weight: 2.8 gm.',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://www.purpicks.com/wp-content/uploads/2018/06/Rejuva-Minerals-Multi-Purpose-Powder-Blush-_-Eye-1.jpg',
    // ),
    // MakeUp(
    //   prodType: 'Bronzer',
    //   id: '2',
    //   prodName: 'Saint Cosmetics Blush',
    //   prodBrand: 'rejuva minerals',
    //   desc:
    //       'Create naturally flushed looking cheeks with Saint Cosmetics blush formulations. Designed to be worn alone or layered for more depth.Features: An ultra-blendable blush with a long-lasting formulaSilky smooth finishCreates a multi-dimensional lookMade in Canada from naturally derived ingredientsChemical Free, Vegan, Gluten Free',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://d3t32hsnjxo7q6.cloudfront.net/i/ed6e230c6394a3c6d1904fcd02a4ae3a_ra,w158,h184_pa,w158,h184.png',
    // ),
    // MakeUp(
    //   prodType: 'Erybrow',
    //   id: '3',
    //   prodName: 'Bronzer - loose',
    //   prodBrand: 'rejuva minerals"',
    //   desc:
    //       'Caribbean is a multi-purpose shade that is suitable for medium-tan skin tones. This shade may be used as a bronzer, or as a contour shade. <ul><li>Our bronzer has been enhanced with Fruits, Botanicals and Clays for their natural color, fragrance and antioxidant benefits!</li><li>Blended with Certified Organics Fruits and Botanicals</li><li>Formulated with common skin irritants.</li><li>Our bronzer will offer a natural “ultra sheer” semi-matte finish.</li><li>Made without any gluten containing ingredients</li><li>VEGAN!</li><li>Eco Friendly jars!',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://www.purpicks.com/wp-content/uploads/2018/03/rejuva-minerals-bronzer.jpg',
    // ),
    // MakeUp(
    //   prodType: 'Eyeliner',
    //   id: '4',
    //   prodName:
    //       'Physicians Formula Argan Wear Ultra-Nourishing Argan Oil Bronzer',
    //   prodBrand: 'physicians formula',
    //   desc:
    //       'Physicians Formula Argan Wear Ultra-Nourishing Argan Oil Bronzer is infused with 100% Pure Argan Oil, known as \"liquid gold\" for its rich conditioning benefits that can improve skins brightness, tone, texture and elasticity. This magical ingredient from Morocco transforms skin, smoothing the appearance of fine lines, brightening dull skin and renewing suppleness, helping to enhance skins youthful glow.Features: Exotically scented formula instantly creates a lit-from-within glowHypoallergenicGluten & Paraben freeNon-comedogenicDermatologist approvedDirections: May be worn alone or over makeup.  Lightly brush powder over face and neck for a natural looking tan glow.  For an exotic glow, apply more over cheekbones.  For the most even application, be sure to tap excess powder from brush before applying.Ingredients: Talc, Mica, Isostearyl Neopentanoate, Fragrance, Polybutene, Argania Spinosa (Argan) Kernel Oil, Ascorbyl Palmitate, C12-15 Alkyl Benzoate, Calcium Sodium Borosilicate, Citric Acid, Glyceryl Oleate, Glyceryl Stearate, Isopropyl Isostearate, Lecithin, Tin Oxide, Tocopherol, Tocopheryl Acetate, Caprylyl Glycol, Hexylene Glycol, Phenoxyethanol. May Contain: Iron Oxides, Titanium Dioxide.',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://d3t32hsnjxo7q6.cloudfront.net/i/ad40b33db806e7c0f0edcddf331dc182_ra,w158,h184_pa,w158,h184.jpg',
    // ),
    // MakeUp(
    //   prodType: 'Eyeshadow',
    //   id: '5',
    //   prodName: 'Saint Cosmetics Blush',
    //   prodBrand: 'maia\'s mineral galaxy',
    //   desc:
    //       'Create naturally flushed looking cheeks with Saint Cosmetics blush formulations. Designed to be worn alone or layered for more depth.Features: An ultra-blendable blush with a long-lasting formulaSilky smooth finishCreates a multi-dimensional lookMade in Canada from naturally derived ingredientsChemical Free, Vegan, Gluten Free',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://www.purpicks.com/wp-content/uploads/2018/06/Maia%E2%80%99s-Mineral-Galaxy-Mineral-Eye-Brow-Liner-Charcoal-Brown.jpg',
    // ),
    // MakeUp(
    //   prodType: 'Foundation',
    //   id: '6',
    //   prodName: 'Saint Cosmetics Blush',
    //   prodBrand: 'rejuva minerals',
    //   desc:
    //       'Create naturally flushed looking cheeks with Saint Cosmetics blush formulations. Designed to be worn alone or layered for more depth.Features: An ultra-blendable blush with a long-lasting formulaSilky smooth finishCreates a multi-dimensional lookMade in Canada from naturally derived ingredientsChemical Free, Vegan, Gluten Free',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://d3t32hsnjxo7q6.cloudfront.net/i/ed6e230c6394a3c6d1904fcd02a4ae3a_ra,w158,h184_pa,w158,h184.png',
    // ),
    // MakeUp(
    //   prodType: 'Lip Liner',
    //   id: '7',
    //   prodName: 'Multi Purpose Powder - Blush & Eye',
    //   prodBrand: 'rejuva minerals',
    //   desc:
    //       'ur Multi Purpose Pressed Powders may be used for blush or eye shadow. Blended with antioxidants from Certified Organic Fruits, Berries &amp; Botanicals*. Made without any gluten containing ingredients. Mica free Pink Parfait and Papaya will offer a natural, ultra sheer semi-matte finish. The petals from beautiful crushed red roses that are found in Pink Parfait, are valued for their natural color and delightful aroma that they provide! Acai Berry will offer a natural, ultra sheer satin finish (mica added). VEGAN. Image one is Pink Parfait. Image two is Papaya, and image three is Acai Berry. Model in image four is wearing Papaya. Model in image five is wearing Acai Berry. To see a demonstration of Papaya, click on the video and fast forward to 3:44. Enjoy! This product is EWG VERIFIED&#x2122; and rated CLEAN in the Think Dirty app! BPA and Phthalate free packaging. Plastic parts of compacts are recyclable. *Tiny flecks of fruit and botanical particles may be visible in powder. Pink Parfait and Papaya are Titanium Dioxide and Mica free. Net Weight: 2.8 gm.',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://www.purpicks.com/wp-content/uploads/2018/06/Rejuva-Minerals-Multi-Purpose-Powder-Blush-_-Eye-1.jpg',
    // ),
    // MakeUp(
    //   prodType: 'Lipstick',
    //   id: '8',
    //   prodName: 'Saint Cosmetics Blush',
    //   prodBrand: 'rejuva minerals',
    //   desc:
    //       'Create naturally flushed looking cheeks with Saint Cosmetics blush formulations. Designed to be worn alone or layered for more depth.Features: An ultra-blendable blush with a long-lasting formulaSilky smooth finishCreates a multi-dimensional lookMade in Canada from naturally derived ingredientsChemical Free, Vegan, Gluten Free',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://d3t32hsnjxo7q6.cloudfront.net/i/ed6e230c6394a3c6d1904fcd02a4ae3a_ra,w158,h184_pa,w158,h184.png',
    // ),
    // MakeUp(
    //   prodType: 'Mascara',
    //   id: '9',
    //   prodName: 'Bronzer - loose',
    //   prodBrand: 'rejuva minerals"',
    //   desc:
    //       'Caribbean is a multi-purpose shade that is suitable for medium-tan skin tones. This shade may be used as a bronzer, or as a contour shade. <ul><li>Our bronzer has been enhanced with Fruits, Botanicals and Clays for their natural color, fragrance and antioxidant benefits!</li><li>Blended with Certified Organics Fruits and Botanicals</li><li>Formulated with common skin irritants.</li><li>Our bronzer will offer a natural “ultra sheer” semi-matte finish.</li><li>Made without any gluten containing ingredients</li><li>VEGAN!</li><li>Eco Friendly jars!',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://www.purpicks.com/wp-content/uploads/2018/03/rejuva-minerals-bronzer.jpg',
    // ),
    // MakeUp(
    //   prodType: 'Nail Polish',
    //   id: '10',
    //   prodName:
    //       'Physicians Formula Argan Wear Ultra-Nourishing Argan Oil Bronzer',
    //   prodBrand: 'physicians formula',
    //   desc:
    //       'Physicians Formula Argan Wear Ultra-Nourishing Argan Oil Bronzer is infused with 100% Pure Argan Oil, known as \"liquid gold\" for its rich conditioning benefits that can improve skins brightness, tone, texture and elasticity. This magical ingredient from Morocco transforms skin, smoothing the appearance of fine lines, brightening dull skin and renewing suppleness, helping to enhance skins youthful glow.Features: Exotically scented formula instantly creates a lit-from-within glowHypoallergenicGluten & Paraben freeNon-comedogenicDermatologist approvedDirections: May be worn alone or over makeup.  Lightly brush powder over face and neck for a natural looking tan glow.  For an exotic glow, apply more over cheekbones.  For the most even application, be sure to tap excess powder from brush before applying.Ingredients: Talc, Mica, Isostearyl Neopentanoate, Fragrance, Polybutene, Argania Spinosa (Argan) Kernel Oil, Ascorbyl Palmitate, C12-15 Alkyl Benzoate, Calcium Sodium Borosilicate, Citric Acid, Glyceryl Oleate, Glyceryl Stearate, Isopropyl Isostearate, Lecithin, Tin Oxide, Tocopherol, Tocopheryl Acetate, Caprylyl Glycol, Hexylene Glycol, Phenoxyethanol. May Contain: Iron Oxides, Titanium Dioxide.',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://d3t32hsnjxo7q6.cloudfront.net/i/ad40b33db806e7c0f0edcddf331dc182_ra,w158,h184_pa,w158,h184.jpg',
    // ),
    // MakeUp(
    //   prodType: 'Blush',
    //   id: '11',
    //   prodName: 'Saint Cosmetics Blush',
    //   prodBrand: 'maia\'s mineral galaxy',
    //   desc:
    //       'Create naturally flushed looking cheeks with Saint Cosmetics blush formulations. Designed to be worn alone or layered for more depth.Features: An ultra-blendable blush with a long-lasting formulaSilky smooth finishCreates a multi-dimensional lookMade in Canada from naturally derived ingredientsChemical Free, Vegan, Gluten Free',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://www.purpicks.com/wp-content/uploads/2018/06/Maia%E2%80%99s-Mineral-Galaxy-Mineral-Eye-Brow-Liner-Charcoal-Brown.jpg',
    // ),
    // MakeUp(
    //   prodType: 'Eyeshadow',
    //   id: '12',
    //   prodName: 'Saint Cosmetics Blush',
    //   prodBrand: 'rejuva minerals',
    //   desc:
    //       'Create naturally flushed looking cheeks with Saint Cosmetics blush formulations. Designed to be worn alone or layered for more depth.Features: An ultra-blendable blush with a long-lasting formulaSilky smooth finishCreates a multi-dimensional lookMade in Canada from naturally derived ingredientsChemical Free, Vegan, Gluten Free',
    //   price: 12,
    //   category: 'powder',
    //   img:
    //       'https://d3t32hsnjxo7q6.cloudfront.net/i/ed6e230c6394a3c6d1904fcd02a4ae3a_ra,w158,h184_pa,w158,h184.png',
    // ),
  ];

  List<MakeUp> get makeUpItems {
    return [..._makeUpItems];
  }

  List<MakeUp> get favoriteItems {
    return _makeUpItems.where((el) => el.isFavorite).toList();
  }

  List<MakeUp> get wantItems {
    return _makeUpItems.where((el) => el.isWant).toList();
  }

  List<MakeUp> get boughtItems {
    return _makeUpItems.where((el) => el.isBought).toList();
  }

  MakeUp findById(int id) {
    return _makeUpItems.firstWhere((el) => el.id == id);
  }

  Future<void> fetchAndSetMakeUp() async {
    final url =
        Uri.parse('http://makeup-api.herokuapp.com/api/v1/products.json');

    try {
      final res = await http.get(url);
      // print(json.decode(res.body));
      final extractedData = json.decode(res.body) as List<dynamic>;
      final List<MakeUp> fetchMakeUp = [];
      extractedData.forEach(
        (makeUpData) {
          fetchMakeUp.insert(
            0,
            MakeUp(
              id: makeUpData['id'],
              img: makeUpData['image_link'],
              prodName: makeUpData['name'],
              prodBrand: makeUpData['brand'],
              desc: makeUpData['description'],
              price: makeUpData['price'],
              category: makeUpData['category'],
              prodType: makeUpData['product_type'],
            ),
          );
        },
      );
      _makeUpItems = fetchMakeUp;
      notifyListeners();
    } catch (e) {
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<List<MakeUp>> findByProdType(String prodType) async {
    final url = Uri.parse(
        'http://makeup-api.herokuapp.com/api/v1/products.json?brand=covergirl&product_type=$prodType');

    try {
      final res = await http.get(url);

      final extractedData = json.decode(res.body) as List<dynamic>;

      final fetchedData = extractedData.map(
        (e) => MakeUp(
          id: e?.id,
          img: e?.image_link,
          prodName: e?.name,
          prodBrand: e?.brand,
          desc: e?.description,
          price: e?.price,
          category: e?.category,
          prodType: e?.product_type,
        ),
      );

      return fetchedData.where((e) => e.prodType == prodType).toList();
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  // List<MakeUp> findByProdType(String prodType) {
  //   return _makeUpItems.where((el) => el.prodType == prodType).toList();
  // }
}
