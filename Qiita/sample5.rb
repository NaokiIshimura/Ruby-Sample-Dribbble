# tokenを設定する
token = '<Client Access Token>'
# idを設定する
id = '824210'
# URLを設定する
url = 'https://api.dribbble.com/v1/shots/' + id

# リクエストを送信
require "faraday"

client = Faraday.new
res = client.get do |req|
  req.url url
  req.headers['Authorization'] = "Bearer #{token}"
end

# レスポンスボディをパースする
require "json"

body = JSON.parse res.body

# Shotsの情報を表示する
p body['title']
p body['images']['hidpi']
