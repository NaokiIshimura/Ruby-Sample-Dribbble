# Dribbble API Sample

Dribbble APIを利用したサンプルプログラム

## Shotsの情報を取得する

### 解説

[Dribbble API を Rubyで利用する \- Qiita](https://qiita.com/NaokiIshimura/items/075c19b5bc563799553c)

### サンプルプログラム

- sample1.rb
- sample2.rb
- sample3.rb

### 準備

Client Access Tokenを設定する

```
token = '<Client Access Token>'
```

### 実行

```
$ ruby sample3.rb

>>> STATUS
200
>>> SHOTS:1
"TIWMUG"
"https://cdn.dribbble.com/users/1186561/screenshots/3874835/tiwmug.png"
>>> SHOTS:2
"Russian Yeti"
"https://cdn.dribbble.com/users/1186561/screenshots/3874834/russian_yeti.png"
...
```

---

### 解説


### サンプルプログラム

- sample4.rb
- sample5.rb
- sample6.rb

### 準備

Client Access Tokenを設定する

```
token = '<Client Access Token>'
```

### 実行

```
$ ruby sample6.rb

URL : https://dribbble.com/search?q=iphone
>>> get_dribbble_id
id : 824210
...
>>> get_url_from_id
URL : https://cdn.dribbble.com/users/14268/screenshots/824210/waffle.png
...
```
