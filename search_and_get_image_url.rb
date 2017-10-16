require_relative './lib/dribble'

# tokenを設定する
token = ENV['DRIBBBLE_TOKEN'] || 'xxxxxxxxxx'

# URLを設定する
url = ENV['DRIBBBLE_SEARCH_URL'] || 'https://dribbble.com/search?q=iphone'

# URLにアクセスしてレスポンスボディを取得する
response_body = get_html_body(url)

# レスポンスボディからidを取得する
dribble_id_list = get_dribbble_id(response_body)

# => ["824210", "516103", "1746065", "613490",
#     "1115596", "2121350", "1945593", "543645",
#     "1109343", "606745", "2590603", "2620936"]

# idからurlを取得する
url_list = get_url_from_id(token, dribble_id_list)

# => ["https://cdn.dribbble.com/users/14268/screenshots/824210/waffle.png",
#     "https://cdn.dribbble.com/users/14268/screenshots/1746065/video.gif",
#     "https://cdn.dribbble.com/users/25514/screenshots/2121350/delivery_card.gif",
#     "https://cdn.dribbble.com/users/62319/screenshots/1945593/shot.gif",
#     "https://cdn.dribbble.com/users/40806/screenshots/1109343/redesign_ios7_big.jpg",
#     "https://cdn.dribbble.com/users/25514/screenshots/2590603/pull-down-refresh-liquid-ramotion.gif",
#     "https://cdn.dribbble.com/users/25514/screenshots/2620936/pixty-ios-app-branding-logo-design-ramotion.png"]
