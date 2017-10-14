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
# Main

# tokenを設定する
token = 'xxxxxxxxxx'
# リクエストURLを設定する
url = 'https://api.dribbble.com/v1/shots?sort=recent'

# カレントディレクトリを出力
puts 'current dir : ' + Dir.pwd

# ダウンロード済みのファイルを移動する
move_images

# 画像のURLを取得する
url_list = get_image_url(token, url)

# 画像をダウンロードする
download_image(url_list)
