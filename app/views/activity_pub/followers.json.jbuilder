json.set! "@context", ActivityPub::ActivityStream.new(nil).context
json.id ap_followers_url(account_id: @account.hash_address)
json.type "OrderedCollection"
json.totalItems @follows.total_count

json.orderedItems @follows.collect {|follow| follow.from_account.url_id }