import 'package:quiosque/app/core/data/dtos/category_dto.dart';
import 'package:quiosque/app/core/data/dtos/product_dto.dart';

final List<CategoryDTO> categoriesData = [
  CategoryDTO(category: 'Iscas'),
  CategoryDTO(category: 'Carnes'),
  CategoryDTO(category: 'Peixes'),
  CategoryDTO(category: 'Frutos do Mar'),
  CategoryDTO(category: 'Guarnições'),
  CategoryDTO(category: 'Especiais'),
];

final List<ProductDTO> productData = [
  ProductDTO(
    product: 'Filé de Cação em Cubos',
    price: 60.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Cação com Molho de Camarão',
    price: 70.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Filé de Anchova',
    price: 40.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Filé de Tilápia',
    price: 40.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Filé de Traíra',
    price: 40.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Filé de Pescadinha',
    price: 40.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Tilápia em Postas',
    price: 50.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Traíra em Postas',
    price: 50.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Peruá Frito',
    price: 40.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Pirão de Peixe',
    price: 10.0,
    categoriesId: 3,
  ),
  ProductDTO(
    product: 'Camarão Empanado',
    price: 45.0,
    categoriesId: 4,
  ),
  ProductDTO(
    product: 'Camarão ao Alho e Óleo',
    price: 45.0,
    categoriesId: 4,
  ),
  ProductDTO(
    product: 'Lula Empanada',
    price: 40.0,
    categoriesId: 4,
  ),
  ProductDTO(
    product: 'Trio do Mar (Lula, Camarão e Pescadinha)',
    price: 80.0,
    categoriesId: 4,
  ),
  ProductDTO(
    product: 'Batata Frita',
    price: 20.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Cebola Empanada',
    price: 20.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Feijão Amigo',
    price: 10.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Mocotó',
    price: 20.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Frango a Passarinho',
    price: 35.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Linguiça Calabresa Acebolada',
    price: 30.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Omelete com 2 Recheios',
    price: 15.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Pastel de Camarão',
    price: 7.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Pastel (carne/queijo/frango/carne seca)',
    price: 6.0,
    categoriesId: 1,
  ),
  ProductDTO(
    product: 'Carne Assada',
    price: 40.0,
    categoriesId: 2,
  ),
  ProductDTO(
    product: 'Carne Seca com Aipim',
    price: 60.0,
    categoriesId: 2,
  ),
  ProductDTO(
    product: 'Costelinha Suína',
    price: 35.0,
    categoriesId: 2,
  ),
  ProductDTO(
    product: 'Picanha Suína',
    price: 35.0,
    categoriesId: 2,
  ),
  ProductDTO(
    product: 'Churrasquinho de Panela',
    price: 40.0,
    categoriesId: 2,
  ),
  ProductDTO(
    product: 'Churrasquinho Misto',
    price: 40.0,
    categoriesId: 2,
  ),
  ProductDTO(
    product: 'Arroz',
    price: 10.0,
    categoriesId: 5,
  ),
  ProductDTO(
    product: 'Feijão',
    price: 10.0,
    categoriesId: 5,
  ),
  ProductDTO(
    product: 'Farofa',
    price: 5.0,
    categoriesId: 5,
  ),
  ProductDTO(
    product: 'Salada',
    price: 5.0,
    categoriesId: 5,
  ),
];

const String storeName = 'Kioske Tô na Praia';
const String storePhoneNumber = '(22) 99937-6220';
const String storeCnpj = 'CNPJ';
