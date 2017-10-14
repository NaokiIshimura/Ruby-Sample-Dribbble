require_relative './lib/dribble'
require_relative './lib/file'

# tokenを設定する
token = ENV['DRIBBLE_TOKEN'] || 'xxxxxxxxxx'

# URLを設定する
url = ENV['DRIBBLE_SEARCH_URL'] || 'https://dribbble.com/search?q=iphone'

# カレントディレクトリを出力
puts 'current dir : ' + Dir.pwd

# ダウンロード済みのファイルを移動する
move_images

# URLにアクセスしてレスポンスボディを取得する
response_body = get_html_body(url)

# レスポンスボディからidを取得する
dribble_id_list = get_dribbble_id(response_body)

# idからurlを取得する
url_list = get_url_from_id(token, dribble_id_list)

# 画像をダウンロードする
download_image(url_list)
