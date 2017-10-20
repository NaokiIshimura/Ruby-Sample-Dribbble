require_relative './lib/dribble'
require_relative './lib/file'
require_relative './lib/common'

# tokenを設定する
token = get_token_from_argv(ARGV)

# URLを設定する
url = get_query_from_argv(ARGV)

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
