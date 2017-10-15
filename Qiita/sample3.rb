# tokenを設定する
token = '<Client Access Token>'
# URLを設定する
url = 'https://api.dribbble.com/v1/shots?sort=recent'

# リクエストを送信
require 'faraday'

client = Faraday.new
res = client.get do |req|
  req.url url
  req.headers['Authorization'] = "Bearer #{token}"
end

# レスポンスを表示
puts '>>> STATUS'
p res.status

# レスポンスボディをパースする
require 'json'

body = JSON.parse res.body

# jsonオブジェクトを1つずつ取り出す、
body.each.with_index(1) do |shots, i|

  # Shotsの情報を表示
  puts ">>> SHOTS:#{i}"
  p shots['title']
  p shots['images']['hidpi']

end
