# Projeto Quiosque

Este projeto visa fornecer uma forma rápida e prática de lançar pedidos e calcular os totais das mesas para um quiosque.

## Tecnologias

Este projeto até o momento utiliza as sequintes tecnologias:

- [sqflite](https://pub.dev/packages/sqflite): pacote para uso do banco de dados relacional e local **sqlite** presente em dispositivos móveis. Trás a possibilidade de executar queries estruturadas ou até mesmo usando sintaxe SQL de forma prática e simples.
- [get_it](https://pub.dev/packages/get_it): pacote que tem como funcionalidade atuar como um _service_locator_, permitindo o acesso de forma rápida e prática às instâncias registradas em qualquer lugar da aplicação, independentemente do acesso ao _BuildContext_.
- [injectable](https://pub.dev/packages/injectable): pacote que automatiza o registro das instâncias no _get_it_. Este pacote depende, inclusive, dos pacotes [injectable_generator](https://pub.dev/packages/injectable_generator) e do [build_runner](https://pub.dev/packages/build_runner), ambos sendo parte dos **dev_dependencies** da aplicação, além de depender do próprio _get_it_ em si.

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
