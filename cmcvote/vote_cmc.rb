require "json"

CRYPTO_ID = 9900
last_vote_id = nil
i = 0

while i < 18000 do
  vote_id = JSON.parse(
  `
  curl --proxy 'http://xrdhnwnz-rotate:g6nx9w6ylm27@p.webshare.io:80/' -s 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/vote?id=#{CRYPTO_ID}' \
  -H 'content-type: application/json;charset=UTF-8'
  `
  )["data"]["unregisteredId"]

  if last_vote_id != vote_id
    puts "#{i}: #{vote_id} #{Time.now.to_s}"

    `
    curl -s 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/vote' \
    -H 'accept: application/json, text/plain, */*' \
    -H 'content-type: application/json;charset=UTF-8' \
    --data-raw '{"cryptoId":#{CRYPTO_ID},"voted":1,"votedId":"#{vote_id}"}' \
    `

    last_vote_id = vote_id
    i += 1
  else
    sleep 0.25
  end
end