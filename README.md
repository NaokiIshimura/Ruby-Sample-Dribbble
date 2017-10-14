# Dribbble Sample

Dribbble APIを利用してイメージのURLを取得する

---

# 準備

faradayをインストール

```
$ gem install faraday
```

tokenを設定

```
token = 'xxxxxxxxxx'
```

urlを設定

```
# パラメータ指定なし(sort=popularity と同じ結果になる)
url = 'https://api.dribbble.com/v1/shots'

# パラメータ指定あり
# list=animated, timeframe=yearを指定する場合、
# sort=recentを指定する場合、
url = 'https://api.dribbble.com/v1/shots?sort=recent'
url = 'https://api.dribbble.com/v1/shots?list=animatedtimeframe=year'
```

# 実行

## sample.rb

hidpiイメージのURLを取得して、標準出力に表示する

```
$ ruby sample.rb

https://cdn.dribbble.com/users/59947/screenshots/3855707/dribble_le_corb.jpg
https://cdn.dribbble.com/users/31752/screenshots/3856964/poipu.jpg
https://cdn.dribbble.com/users/116499/screenshots/3854714/chapter-2-marketing-strategies_revised.png
https://cdn.dribbble.com/users/976727/screenshots/3855191/dribbble-upload.png
https://cdn.dribbble.com/users/116499/screenshots/3854687/chapter-3-campaigns.png
https://cdn.dribbble.com/users/12779/screenshots/3857006/trinity_tulips.png
https://cdn.dribbble.com/users/45487/screenshots/3854952/tomatte_dribbble.png
https://cdn.dribbble.com/users/686119/screenshots/3855258/cloud_medical_imaging_website.png
https://cdn.dribbble.com/users/1461712/screenshots/3855875/surfing.png
https://cdn.dribbble.com/users/97602/screenshots/3855784/croc-dribbble02.gif
https://cdn.dribbble.com/users/1615730/screenshots/3854596/shot_2_2.png
https://cdn.dribbble.com/users/1242672/screenshots/3855290/zonaa_preview11.png
```

## download_image_files.rb

1. カレントディレクトリにimageディレクトリを作成して、imageディレクトリ内にhidpiイメージをダウンロードする
2. imageディレクトリが存在してる場合は、イメージをimage_oldディレクトリに移動させた上で1.を実行する

```
$ ruby download_image_files.rb 

current dir : /xxx
mkdir : /xxx/image
success
download : https://cdn.dribbble.com/users/1042211/screenshots/3860184/dribbble_x2.5_copy_0.4x.png
success
save : /xxx/image/users_1042211_screenshots_3860184_dribbble_x2.5_copy_0.4x.png
success
...
```

## search_and_get_image_url.rb

作品を検索して画像のURLを取得する

```
$ ruby search_and_get_image_url.rb

  >>> get_html_body
  URL : https://dribbble.com/search?q=iphone
  >>> get_dribbble_id
  id : 824210
  id : 516103
  id : 1746065
  id : 613490
  id : 1115596
  id : 2121350
  id : 1945593
  id : 543645
  id : 1109343
  id : 606745
  id : 2590603
  id : 2620936
  >>> get_url_from_id
  URL : https://cdn.dribbble.com/users/14268/screenshots/824210/waffle.png
  URL : https://cdn.dribbble.com/users/14268/screenshots/1746065/video.gif
  URL : https://cdn.dribbble.com/users/25514/screenshots/2121350/delivery_card.gif
  URL : https://cdn.dribbble.com/users/62319/screenshots/1945593/shot.gif
  URL : https://cdn.dribbble.com/users/40806/screenshots/1109343/redesign_ios7_big.jpg
  URL : https://cdn.dribbble.com/users/25514/screenshots/2590603/pull-down-refresh-liquid-ramotion.gif
  URL : https://cdn.dribbble.com/users/25514/screenshots/2620936/pixty-ios-app-branding-logo-design-ramotion.png
```
