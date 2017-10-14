# URLにアクセスして、bodyを返却する
# @param  [String] request_url
# @return [String] response body
def get_html_body(request_url)

  puts '>>> get_html_body'
  puts 'URL : ' + request_url

  require "faraday"

  # リクエストを送信
  client = Faraday.new
  res = client.get do |req|
    req.url request_url
  end

  # レスポンスのステータスコードを取得
  http_response_status_code = res.status

  # ステータスコードが200ならボディを返却する
  # ステータスコードが200以外なら終了する
  if http_response_status_code == 200
    return res.body
  else
    puts 'HTTP Status Code : ' + http_response_status_code.to_s
    exit
  end

end

# HTMLを解析して、Dribbleに投稿された作品のidを返却する
# @param  [String] response_body
# @return [Array]  dribbble_id_list
def get_dribbble_id(response_body)

  puts '>>> get_dribbble_id'

  require "nokogiri"

  begin

    # HTMLをparseする
    doc = Nokogiri::HTML.parse(response_body, nil, 'utf-8')

    # タイトルを表示する
    # puts 'title : ' + doc.title

    # xpathに一致するelementを取得する
    selector = "//*[contains(@id, 'screenshot-')]"
    elements = doc.xpath(selector)

    # 取得したidを格納する配列
    dribble_id_list = []

    # elementから値を取得する
    elements.each do |e|

      # elementからidの値を取得
      element_id = e.attribute("id").value
      # elementのidから不要な文字列を取り除く
      dribble_id = element_id.gsub('screenshot-', '')

      puts 'id : ' + dribble_id

      # 配列に追加
      dribble_id_list.push(dribble_id)

    end

    # 配列を返却する
    return dribble_id_list

  rescue
    # エラーが発生したら終了する
    puts 'fail'
    exit
  end

end

##
# Main

# URLを設定する
url = 'https://dribbble.com/search?q=iphone'

# URLにアクセスしてレスポンスボディを取得する
response_body = get_html_body(url)

# レスポンスボディからidを取得する
dribble_id_list = get_dribbble_id(response_body)

# => ["824210", "516103", "1746065", "613490",
#     "1115596", "2121350", "1945593", "543645",
#     "1109343", "606745", "2590603", "2620936"]
