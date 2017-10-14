require_relative './lib/dribble'
require_relative './lib/file'

# tokenを設定する
token = 'xxxxxxxxxx'
# リクエストURLを設定する
url = 'https://api.dribbble.com/v1/shots?sort=recent'

# カレントディレクトリを出力
puts 'current dir : ' + Dir.pwd

# ダウンロード済みのファイルを移動する
move_images

# 画像のURLを取得する
url_list = get_image_url(token, url)

# 画像をダウンロードする
download_image(url_list)
