require 'faraday'
require 'json'

# tokenを設定する
token = 'xxxxxxxxxx'

# URLを設定する
url = 'https://api.dribbble.com/v1/shots?sort=recent'

# リクエストを送信
client = Faraday.new
res = client.get do |req|
  req.url url
  req.headers['Authorization'] = "Bearer #{token}"
end

http_response_status_code = res.status

# レスポンスステータスコードが200なら、
if http_response_status_code == 200

  # レスポンスボディをパースする
  body = JSON.parse res.body

  # jsonオブジェクトを1つずつ取り出す、
  body.each do |b|
    # jsonからimages > hidpiの値(URL)を取り出す
    hidpi_url = b['images']['hidpi']
    # 値(URL)がnilじゃなければ出力する
    puts hidpi_url unless hidpi_url.nil?
  end

# レスポンスステータスコードが200以外なら、
else

  # レスポンスステータスコードを出力する
  puts 'HTTP Status Code : ' + http_response_status_code.to_s

end
