require_relative './lib/dribble'
require_relative './lib/file'

# tokenを設定する
token = ENV['DRIBBBLE_TOKEN'] || 'xxxxxxxxxx'

# URLを設定する
if ARGV[0] != nil
  url = 'https://dribbble.com/search?q=' + ARGV[0]
else
  url = ENV['DRIBBBLE_SEARCH_URL'] || 'https://dribbble.com/search?q=iphone'
end

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
