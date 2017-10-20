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

# URLにアクセスしてレスポンスボディを取得する
response_body = get_html_body(url)

# レスポンスボディからidを取得する
dribble_id_list = get_dribbble_id(response_body)

# idからurlを取得する
url_list = get_url_from_id(token, dribble_id_list)

# 画像をダウンロードする
download_image(url_list)
