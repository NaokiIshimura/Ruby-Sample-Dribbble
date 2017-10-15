url = 'https://dribbble.com/search?q=iphone&page=2'

require "faraday"

# リクエストを送信
client = Faraday.new
res = client.get do |req|
  req.url url
end

response_body = res.body

require "nokogiri"

# HTMLをparseする
doc = Nokogiri::HTML.parse(response_body, nil, 'utf-8')

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

