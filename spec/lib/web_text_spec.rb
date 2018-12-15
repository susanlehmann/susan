require 'rails_helper'

describe WebText do
  it 'replaces usernames with links' do
    formatted = WebText.format("hello @killua")
    # ap formatted
    expect(formatted).to include("<a href='/u/killua' class='web-text__username'>@killua</a>")
    expect(formatted).to eql("hello <a href='/u/killua' class='web-text__username'>@killua</a>")
  end

  it 'replaces hashtags' do
    formatted = WebText.format("hey #hashtag")
    expect(formatted).to include("<a href='/all?query=%23hashtag' class='web-text__hashtag'>#hashtag</a>")
  end

  it 'doesnt replace odd colons' do
    formatted = WebText.format('hey office:')
    expect(formatted).to eql('hey office:')
  end

  it 'works at the start' do
    formatted = WebText.format("@killua")
    expect(formatted).to eql("<a href='/u/killua' class='web-text__username'>@killua</a>")
  end

  it 'works with punctuation after mention' do
    formatted = WebText.format("hey @killua!")
    expect(formatted).to eql("hey <a href='/u/killua' class='web-text__username'>@killua</a>!")

    formatted = WebText.format("hey @killua?")
    expect(formatted).to eql("hey <a href='/u/killua' class='web-text__username'>@killua</a>?")

    formatted = WebText.format("hey @killua.")
    expect(formatted).to eql("hey <a href='/u/killua' class='web-text__username'>@killua</a>.")

    formatted = WebText.format("hey @killua,")
    expect(formatted).to eql("hey <a href='/u/killua' class='web-text__username'>@killua</a>,")
  end

  it 'replaces cashtags' do
    formatted = WebText.format("hey $bloblo")
    expect(formatted).to include("<a href='/all?query=$bloblo' class='web-text__hashtag'>$bloblo</a>")
  end

  it 'works with ipfs' do
    formatted = WebText.format("hey visit ipfs://asdf")
    expect(formatted).to include("<a href='ipfs://asdf' target='_blank' class='web-text__url'>ipfs://asdf</a>")
  end

  it 'replaces links' do
    formatted = WebText.format("hey visit https://example.com")
    expect(formatted).to include("<a href='https://example.com' target='_blank' class='web-text__url'>https://example.com</a>")
  end

  it 'replaces multiple' do
    formatted = WebText.format("hey yo @you and @yall, check out $bloblo! #totheroof-yeah")
    expect(formatted).to include("<a href='/u/you' class='web-text__username'>@you</a>")
    expect(formatted).to include("<a href='/u/yall' class='web-text__username'>@yall</a>")
    expect(formatted).to include("<a href='/all?query=$bloblo' class='web-text__hashtag'>$bloblo</a>")
    expect(formatted).to include("<a href='/all?query=%23totheroof' class='web-text__hashtag'>#totheroof</a>")
  end

  it 'extracts mentions' do
    usernames = WebText.mentions('hey @killua and @thame, talk to @judas.')
    expect(usernames).to include('killua')
    expect(usernames).to include('thame')
    expect(usernames).to include('judas')
  end

  it 'works with fediverse handles' do
    formatted = WebText.format("im @hstove@mastodon.social")
    expect(formatted).to include("<a href='/federated/accounts/search?handle=@hstove@mastodon.social' class='web-text__username'>@hstove@mastodon.social</a>")
  end

  it 'works with more complex fediverse handles' do
    formatted = WebText.format("im @haru.i_n0731@mst-dn.y-zu.org")
    expect(formatted).to include("<a href='/federated/accounts/search?handle=@haru.i_n0731@mst-dn.y-zu.org' class='web-text__username'>@haru.i_n0731@mst-dn.y-zu.org</a>")
  end
end