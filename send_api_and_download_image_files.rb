require_relative './lib/dribble'
require_relative './lib/file'

# tokenを設定する
token = ENV['DRIBBBLE_TOKEN'] || 'xxxxxxxxxx'

# URLを設定する
url = ENV['DRIBBBLE_API_URL'] || 'https://api.dribbble.com/v1/shots?sort=recent'

# カレントディレクトリを出力
puts 'current dir : ' + Dir.pwd

# ダウンロード済みのファイルを移動する
# (不要ならコメントアウトする)
src = Dir.pwd + '/' + 'image'
dst = Dir.pwd + '/' + 'image_old'
move_images(src, dst)

# 画像のURLを取得する
url_list = get_image_url(token, url)

# 画像をダウンロードする
download_image(url_list)
