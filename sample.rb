require "faraday"
require "json"

# tokenを設定する
token = 'xxxxxxxxxx'

# リクエストURLを設定する
url = 'https://api.dribbble.com/v1/shots?sort=recent'

# リクエストを送信
client = Faraday.new
res = client.get do |req|
  req.url url
  req.headers['Authorization'] = "Bearer #{token}"
end

# レスポンスボディをパースする
body = JSON.parse res.body

# レスポンスボディからimages > hidpiの値を取り出す
body.each do |b|
  hidpi_url = b["images"]["hidpi"]
  puts hidpi_url if hidpi_url != nil
end
