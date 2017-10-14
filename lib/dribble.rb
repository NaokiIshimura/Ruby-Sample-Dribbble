# Dribbbleからhidpi画像のURLを取得する
# @param [String] token
# @param [String] url
# @return [Array] url_list
def get_image_url(token, url)

  require "faraday"
  require "json"

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

    url_list = []

    # レスポンスボディからimages > hidpiの値を取り出す
    body.each do |b|
      hidpi_url = b["images"]["hidpi"]
      url_list.push(hidpi_url) if hidpi_url != nil
    end

    return url_list

  else
    puts 'HTTP Status Code : ' + http_response_status_code.to_s
    exit
  end
end

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

# idからshot情報を取得する
# @params [String] token
# @params [Array]  id_list
# @return [Array]  shot_url_list
def get_url_from_id(token, id_list)

  puts '>>> get_url_from_id'

  shot_url_list = []
  id_list.each do |id|
    # idからshotのhidpi画像URLを取得する
    url = get_a_shot(token, id)
    if url != nil
      shot_url_list.push(url)
    end
  end
  return shot_url_list
end

# idからshotのhidpi画像URLを取得する
# @param [String] token
# @param [String] id
# @return [String] hidpi_url
def get_a_shot(token, id)
  require "faraday"
  require "json"

  # リクエストURLを設定する
  request_url = 'https://api.dribbble.com/v1/shots/' + id

  # リクエストを送信
  client = Faraday.new
  res = client.get do |req|
    req.url request_url
    req.headers['Authorization'] = "Bearer #{token}"
  end

  http_response_status_code = res.status

  if http_response_status_code == 200

    # レスポンスボディをパースする
    body = JSON.parse res.body

    # レスポンスボディからimages > hidpiの値を取り出す
    hidpi_url = body["images"]["hidpi"]
    if hidpi_url != nil
      puts 'URL : ' + hidpi_url
      return hidpi_url
    else
      return nil
    end

  else

    puts 'HTTP Status Code : ' + http_response_status_code.to_s
    return nil
  end
end
