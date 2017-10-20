# 引数からtokenを取り出す
# @params [Array] argv
# @return [String] token
def get_token_from_argv(argv)
  if argv.empty?
    puts '第一引数にはClient Access Tokenを設定してください。'
    puts '第二引数には検索ワードを設定してください。'
    exit
  end
  argv[0]
end

# 引数から検索ワードを取り出してURLを返す
# @params [Array] argv
# @return [String] url
def get_query_from_argv(argv)
  if argv.length == 2
    'https://dribbble.com/search?q=' + argv[1]
  else
    'https://dribbble.com'
  end
end
