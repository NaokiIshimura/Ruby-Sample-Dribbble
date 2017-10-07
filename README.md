# Dribbble Sample

Dribbble APIを利用してイメージのURLを取得する

https://dri-bbble-slideshow.herokuapp.com/

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
