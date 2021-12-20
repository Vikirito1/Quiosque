# Projeto Quiosque

Este projeto visa fornecer uma forma rápida e prática de lançar pedidos e calcular os totais das mesas para um quiosque.

## Tecnologias

Este projeto até o momento utiliza as sequintes tecnologias:

- [sqflite](https://pub.dev/packages/sqflite): pacote para uso do banco de dados relacional e local **sqlite** presente em dispositivos móveis. Trás a possibilidade de executar queries estruturadas ou até mesmo usando sintaxe SQL de forma prática e simples.
- [get_it](https://pub.dev/packages/get_it): pacote que tem como funcionalidade atuar como um _service_locator_, permitindo o acesso de forma rápida e prática às instâncias registradas em qualquer lugar da aplicação, independentemente do acesso ao _BuildContext_.
- [injectable](https://pub.dev/packages/injectable): pacote que automatiza o registro das instâncias no _get_it_. Este pacote depende, inclusive, dos pacotes [injectable_generator](https://pub.dev/packages/injectable_generator) e do [build_runner](https://pub.dev/packages/build_runner), ambos sendo parte dos **dev_dependencies** da aplicação, além de depender do próprio _get_it_ em si.
- [mobx](https://pub.dev/packages/mobx): o MobX é um padrão de gerência de estados que torna simples "conectar" dados reativos à UI das aplicações. Este pacote é basicamente um port do [mobx](https://github.com/mobxjs/mobx), originalmente desenvolvido para o Javascript. A documentação do pacote é bem completa e pode ser utilizada como material de apoio para a obtenção de mais detalhes de seu funcionamento.
- [flutter_mobx](https://pub.dev/packages/flutter_mobx): pacote que contém o widget "Observer", que escuta as alterações dos _observables_ e automaticamente se reconstrói.
- [mobx_codegen](https://pub.dev/packages/mobx_codegen): pacote que adiciona suporte aos _annotations_ `@observable`, `@action` e `@computed` e gera o código automaticamente em conjunto com o [build_runner](https://pub.dev/packages/build_runner), ambos sendo parte dos **dev_dependencies** da aplicação.
- [json_annotation](https://pub.dev/packages/json_annotation): define as anotações usadas pelo pacote _json_serializable_ para criar código de serialização e desserialização de JSON.
- [json_serializable](https://pub.dev/packages/json_serializable): fornece a opção de gerar automaticamente código de serialização e desserialização de JSON em classes anotadas com as anotações do _json_annotation_.
- [equatable](https://pub.dev/packages/equatable): facilita a comparação de objetos em Dart.

## Uso

### build_runner

Primeiramente é importante entender o que é o pacote _build_runner_.

O _build_runner_ é um pacote que permite a geração automática de trechos de código a serem usados na aplicação. Com este pacote, faremos uso dos seguintes comandos:

- Gerar os arquivos de código automático uma única vez:

```bash
flutter pub run build_runner build
```

- Gerar os arquivos de código automático e ficar escutando alterações:

```bash
flutter pub run build_runner watch
```

Baixar ou clonar repositórios, ou até mesmo limpar os arquivos da aplicação com o comando `flutter clean`, podem ocasionar conflitos na atualização de arquivos previamente gerados. Para resolver este problema basta incluir no comando a flag `--delete-conflicting-outputs`.

Por fim, é recomendado o uso do comando:

```bash
flutter pub run build_runner --delete-conflicting-outputs
```

### injectable

Conforme apontado anteriormente, o _injectable_ será utilizado para automatizar o registro das classes no service locator _get_it_.
As instruções de configuração do _injectable_ podem ser encontradas na própria documentação, mas basicamente consiste em criar um arquivo de configuração e adicionar as seguintes instruções:

```dart
// Arquivo service_locator_config.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator_config.config.dart'; // O inicio do nome deste arquivo deve ser igual ao arquivo .dart onde este código será adicionado

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);
```

Num primeiro instante, o arquivo `service_locator_config.config.dart` ainda não existe. Este arquivo é gerado automaticamente pelo pacote _build_runner_. Para gerá-lo, basta utilizar um dos comandos da seção anterior.

Por fim, basta executar o comando `configureDependencies()` antes do `runApp()` em **main.dart**:

```dart
void main() {
  configureDependencies();
  runApp(MyApp());
}
```

Para registrar a instância de uma classe no _get_it_, basta fazer uso de uma das anotações a seguir:

- `@Injectable()` - cria uma nova instância a cada "invocação"
- `@Singleton()` - cria uma nova e **única** instância no instante em que a aplicação é iniciada
- `@LazySingleton()` - cria uma nova e **única** instância somente quando o uso for demandado

Todas as três anotações suportam o argumento `as:`, muito importante quando trabalha-se com interfaces. Exemplo:

```dart
@LazySingleton(as: IOrdersRepository)
class OrdersRepository implements IOrdersRepository {
    ...
}
```

### mobx / mobx_codegen

Conforme mencionado anteriormente, o _mobx_ é um padrão de gerência de estados inicialmente criado para aplicações Javascript. Seu conceito gira em torno de três pilares: **Observables**, **Actions** e **Reactions**.

As variáveis definidas como _Observables_ são variáveis que, ao mudar seu valor, deseja-se que a UI se reconstrua. Normalmente são associadas aos estados da aplicação.

As _Actions_ são os métodos capazes de "disparar" o sinal para reconstruir a UI e geralmente são usados para alterar os valores das _Observables_.

As _Reactions_ geralmente são quem disparam as _Actions_.

Um exemplo simples de uso do _mobx_ pode ser encontrado abaixo:

```dart
class Counter {
  Counter() {
    increment = Action(_increment);
  }

  final _value = Observable(0);
  int get value => _value.value;

  set value(int newValue) => _value.value = newValue;
  Action increment;

  void _increment() {
    _value.value++;
  }
}
```

A partir do trecho de código acima pode-se perceber que existe uma certa quantidade de _boilerplate_, que pode tornar o código muito massante em classes mais complexas. Para auxiliar com esta questão, pode-se utilizar o pacote _mobx_codegen_, permitindo substituir o trecho acima por:

```dart
// Arquivo counter.dart
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
```

Como agora existe o uso da geração automática de código, deve-se lembrar de usar um dos comandos descritos na seção sobre o [_build_runner_](#build_runner) para a criação do arquivo _.g.dart_ associado.

### flutter_mobx

Este pacote traz o widget _Observer_ a ser utilizado na UI. Este widget basicamente escuta todas as alterações dos _Observables_ dentro dele e reconstrói seu conteúdo.

```dart
Observer(
  builder: (_) => Text(
    '${_counter.value}',
    style: const TextStyle(fontSize: 20),
  ),
),
```

### json_annotation / json_serializable

Geralmente estes pacotes são usados em classes "modelos" ou "entidades" que precisam ser convertidas de/para Map (equivalente ao JSON no Dart). Seu uso é bem simples: inicialmente basta adicionar a anotação `@JsonSerializable()` à classe a ser convertida e declarar os métodos _fromJson_ e _toJson_. Adicionalmente, como este recurso faz uso de geração automática de código, deve-se incluir o _.g.dart_ no arquivo. Um exemplo pode ser encontrado abaixo.

```dart
// Arquivo product_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  const ProductModel({
    required this.id,
    required this.product,
    required this.price,
    this.quantity = 0,
  });

  final int id;
  final String product;
  final double price;
  final int? quantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
```

### equatable

Este pacote visa facilitar a comparação de objetos em Dart, que normalmente apenas verifica o endereço de memória e a menos que duas instâncias apontem para o mesmo endereço, a comparação retorna falso mesmo que ambas instâncias possuam os mesmos atributos.

Para efetuar a correta comparação deve-se sobrescrever o operador `==` e o `hashCode` da classe, conforme o exemplo abaixo.

```dart
class PersonModel {
  const PersonModel({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonModel &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode;
}
```

Porém este processo pode ser bastante tedioso e para um número maior de atributos aumenta-se a chance de erro. Uma alternativa à esta abordagem é o uso do pacote `equatable`.

Para utilizá-lo, basta fazer a classe em questão herdar de `Equatable` (ou utilizar o mixin `with EquatableMixin`, caso a classe já esteja herdando de outra). Em seguida, basta sobrescrever o _getter_ `props` passando a lista dos parâmetros que devem ser levados em consideração na comparação.

```dart
import 'package:equatable/equatable.dart';

class PersonModel extends Equatable {
  const PersonModel({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  @override
  List<Object> get props => [firstName, lastName];
}
```
