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

http_response_status_code = res.status

if http_response_status_code == 200

  # レスポンスボディをパースする
  body = JSON.parse res.body

  # レスポンスボディからimages > hidpiの値を取り出す
  body.each do |b|
    hidpi_url = b["images"]["hidpi"]
    puts hidpi_url if hidpi_url != nil
  end

else

  puts 'HTTP Status Code : ' + http_response_status_code.to_s

end
