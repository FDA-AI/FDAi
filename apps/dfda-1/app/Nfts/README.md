# Laravel Tokenize

👍 User-tokenize features for Laravel Application.

![CI](https://github.com/overtrue/laravel-tokenize/workflows/CI/badge.svg)

[![Sponsor me](https://github.com/overtrue/overtrue/blob/master/sponsor-me-button-s.svg?raw=true)](https://github.com/sponsors/overtrue)

## Installing

```shell
composer require overtrue/laravel-tokenize -vvv
```

### Configuration

This step is optional

```php
php artisan vendor:publish --provider="Overtrue\\LaravelTokenize\\NftServiceProvider" --tag=config
```

### Migrations

This step is also optional, if you want to custom nfts table, you can publish the migration files:

```php
php artisan vendor:publish --provider="Overtrue\\LaravelTokenize\\NftServiceProvider" --tag=migrations
```

## Usage

### Traits

#### `App\Nfts\Traits\Tokenizer`

```php

use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use App\Nfts\Traits\Tokenizer;

class User extends Authenticatable
{
    use Tokenizer;

    <...>
}
```

#### `App\Nfts\Traits\Tokenizeable`

```php
use Illuminate\Database\Eloquent\Model;
use App\Nfts\Traits\Tokenizable;

class Post extends Model
{
    use Tokenizable;

    <...>
}
```

### API

```php
$user = User::find(1);
$post = Post::find(2);

$user->tokenize($post);
$user->untokenize($post);
$user->toggleTokenize($post);

$user->hasTokenized($post);
$post->isTokenizedBy($user);
```

Get user nfts with pagination:

```php
$nfts = $user->nfts()->with('tokenizable')->paginate(20);

foreach ($nfts as $tokenize) {
    $tokenize->tokenizable; // App\Post instance
}
```

Get object tokenizers:

```php
foreach($post->tokenizers as $user) {
    // echo $user->name;
}
```

with pagination:

```php
$tokenizers = $post->tokenizers()->paginate(20);

foreach($tokenizers as $user) {
    // echo $user->name;
}
```

### Aggregations

```php
// all
$user->nfts()->count();

// with type
$user->nfts()->withType(Post::class)->count();

// tokenizers count
$post->tokenizers()->count();
```

List with `*_count` attribute:

```php
// nfts_count
$users = User::withCount('nfts')->get();

foreach($users as $user) {
    // $user->nfts_count;
}

// tokenizers_count
$posts = User::withCount('tokenizers')->get();

foreach($posts as $post) {
    // $post->nfts_count;
}
```

### N+1 issue

To avoid the N+1 issue, you can use eager loading to reduce this operation to just 2 queries. When querying, you may specify which relationships should be eager loaded using the `with` method:

```php
// Tokenizer
$users = App\User::with('nfts')->get();

foreach($users as $user) {
    $user->hasTokenized($post);
}

// Tokenizeable
$posts = App\Post::with('nfts')->get();
// or
$posts = App\Post::with('tokenizers')->get();

foreach($posts as $post) {
    $post->isTokenizedBy($user);
}
```

Of course we have a better solution, which can be found in the following section：

### Attach user tokenize status to tokenizable collection

You can use `Tokenizer::attachTokenizeStatus($tokenizables)` to attach the user tokenize status, it will attach `has_tokenized` attribute to each model of `$tokenizables`:

#### For model
```php
$post = Post::find(1);

$post = $user->attachTokenizeStatus($post);

// result
[
    "id" => 1
    "title" => "Add socialite login support."
    "created_at" => "2021-05-20T03:26:16.000000Z"
    "updated_at" => "2021-05-20T03:26:16.000000Z"
    "has_tokenized" => true
 ],
```

#### For `Collection | Paginator | LengthAwarePaginator | array`:

```php
$posts = Post::oldest('id')->get();

$posts = $user->attachTokenizeStatus($posts);

$posts = $posts->toArray();

// result
[
  [
    "id" => 1
    "title" => "Post title1"
    "created_at" => "2021-05-20T03:26:16.000000Z"
    "updated_at" => "2021-05-20T03:26:16.000000Z"
    "has_tokenized" => true
  ],
  [
    "id" => 2
    "title" => "Post title2"
    "created_at" => "2021-05-20T03:26:16.000000Z"
    "updated_at" => "2021-05-20T03:26:16.000000Z"
    "has_tokenized" => fasle
  ],
  [
    "id" => 3
    "title" => "Post title3"
    "created_at" => "2021-05-20T03:26:16.000000Z"
    "updated_at" => "2021-05-20T03:26:16.000000Z"
    "has_tokenized" => true
  ],
]
```

#### For pagination

```php
$posts = Post::paginate(20);

$user->attachTokenizeStatus($posts);
```

### Events

| **Event**                             | **Description**                             |
| ------------------------------------- | ------------------------------------------- |
| `App\Nfts\Events\Tokenized`   | Triggered when the relationship is created. |
| `App\Nfts\Events\Untokenized` | Triggered when the relationship is deleted. |

## Related packages

-   Follow: [overtrue/laravel-follow](https://github.com/overtrue/laravel-follow)
-   Tokenize: [overtrue/laravel-tokenize](https://github.com/overtrue/laravel-tokenize)
-   Favorite: [overtrue/laravel-favorite](https://github.com/overtrue/laravel-favorite)
-   Subscribe: [overtrue/laravel-subscribe](https://github.com/overtrue/laravel-subscribe)
-   Vote: [overtrue/laravel-vote](https://github.com/overtrue/laravel-vote)
-   Bookmark: overtrue/laravel-bookmark (working in progress)

## :heart: Sponsor me

[![Sponsor me](https://github.com/overtrue/overtrue/blob/master/sponsor-me.svg?raw=true)](https://github.com/sponsors/overtrue)

如果你喜欢我的项目并想支持它，[点击这里 :heart:](https://github.com/sponsors/overtrue)

## Project supported by JetBrains

Many thanks to Jetbrains for kindly providing a license for me to work on this and other open-source projects.

[![](https://resources.jetbrains.com/storage/products/company/brand/logos/jb_beam.svg)](https://www.jetbrains.com/?from=https://github.com/overtrue)

## Contributing

You can contribute in one of three ways:

1. File bug reports using the [issue tracker](https://github.com/overtrue/laravel-nfts/issues).
2. Answer questions or fix bugs on the [issue tracker](https://github.com/overtrue/laravel-nfts/issues).
3. Contribute new features or update the wiki.

_The code contribution process is not very formal. You just need to make sure that you follow the PSR-0, PSR-1, and PSR-2 coding guidelines. Any new code contributions must be accompanied by unit tests where applicable._

## PHP 扩展包开发

> 想知道如何从零开始构建 PHP 扩展包？
>
> 请关注我的实战课程，我会在此课程中分享一些扩展开发经验 —— [《PHP 扩展包实战教程 - 从入门到发布》](https://learnku.com/courses/creating-package)

## License

MIT
