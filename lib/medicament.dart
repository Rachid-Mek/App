
class Product {
  final int id, price;
  final String image, name;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });
}

List<Product> products = [
  Product(
    id: 1,
    image:
        'https://www.tarifs.info/online/pictures/cache/doliprane-1000mg-8-comprimes-sanofi-drmarche_9067_0_0_700_700_52615531_63791.png',
    name: 'Doliprane',
    price: 100,
  ),
  Product(
    id: 2,
    image:
        'https://www.tarifs.info/online/pictures/cache/doliprane-1000mg-8-comprimes-sanofi-drmarche_9067_0_0_700_700_52615531_63791.png',
    name: 'Doliprane 2000',
    price: 250,
  ),
  Product(
      id: 3,
      image:
          'https://www.tarifs.info/online/pictures/cache/doliprane-1000mg-8-comprimes-sanofi-drmarche_9067_0_0_700_700_52615531_63791.png',
      name: 'Doliprane 3000',
      price: 50),
  Product(
    id: 4,
    image:
        'https://www.tarifs.info/online/pictures/cache/doliprane-1000mg-8-comprimes-sanofi-drmarche_9067_0_0_700_700_52615531_63791.png',
    name: 'Doliprane',
    price: 170,
  ),
  Product(
    id: 5,
    image:
        'https://www.tarifs.info/online/pictures/cache/doliprane-1000mg-8-comprimes-sanofi-drmarche_9067_0_0_700_700_52615531_63791.png',
    name: 'Doliprane',
    price: 100,
  )
];
