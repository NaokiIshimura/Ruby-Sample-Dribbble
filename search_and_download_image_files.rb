##
# download_image_files

# Dribbbleからhidpi画像のURLを取得する
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

# 画像を保存する
def download_image(url_list)
  url_list.each do |url|

    # 画像を保存するパスを設定する
    file_name = url.gsub('https://cdn.dribbble.com/', '').gsub('/', '_')
    file_dir = Dir.pwd + '/' + 'image'
    file_path = file_dir + '/' + file_name

    # 保存先ディレクトリが存在しない場合は作成する
    if FileTest.directory?(file_dir) == false
      begin
        puts 'mkdir : ' + file_dir
        Dir.mkdir(file_dir)
        puts 'success'
      rescue
        puts 'fail'
        exit
      end
    end

    # 画像を取得する
    image_file = get_image_file(url)

    if image_file != nil
      # 画像を保存する
      puts 'save : ' + file_path

      begin
        File.open(file_path, 'wb') {|fp| fp.write(image_file)}
        puts 'success'
      rescue
        puts 'fail'
        exit
      end
    end
  end
end

# 画像を取得する
def get_image_file(url)
  require "faraday"

  puts 'download : ' + url
  res = Faraday.get url

  if res.status == 200
    puts 'success'
    return res.body
  else
    puts 'HTTP Status Code : ' + http_response_status_code.to_s
    exit
  end
end

# ダウンロード済みのファイルを移動する
def move_images

  old_dir = Dir.pwd + '/' + 'image'
  new_dir = Dir.pwd + '/' + 'image_old'

  # 移動元ディレクトリが存在しない場合はreturn
  if FileTest.directory?(old_dir) == false
    return
  end

  # 移動先ディレクトリが存在しない場合は作成する
  if FileTest.directory?(new_dir) == false

    begin
      puts 'mkdir : ' + new_dir
      Dir.mkdir(new_dir)
      puts 'success'
    rescue
      puts 'fail'
      exit
    end
  end

  begin
    puts 'move files : ' + old_dir + ' to ' + new_dir
    require 'fileutils'
    FileUtils.mv(Dir.glob("#{old_dir}/*"), new_dir + '/')
    puts 'success'
  rescue
    puts 'fail'
    exit
  end
end

##
# search_and_get_image_url

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

def get_url_from_id(token, id_list)

  puts '>>> get_url_from_id'

  url_list = []
  id_list.each do |id|
    url = get_a_shot(token, id)
    if url != nil
      url_list.push(url)
    end
  end
  return url_list
end

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

##
# Main

# tokenを設定する
token = 'xxxxxxxxxx'
# URLを設定する
url = 'https://dribbble.com/search?q=iphone'

# カレントディレクトリを出力
puts 'current dir : ' + Dir.pwd

# ダウンロード済みのファイルを移動する
move_images

# URLにアクセスしてレスポンスボディを取得する
response_body = get_html_body(url)

# レスポンスボディからidを取得する
dribble_id_list = get_dribbble_id(response_body)

# idからurlを取得する
url_list = get_url_from_id(token, dribble_id_list)

# 画像をダウンロードする
download_image(url_list)
