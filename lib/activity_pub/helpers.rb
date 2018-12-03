module ActivityPub
  module Helpers
    include ActiveSupport::Concern

    def hashie_data
      Hashie::Mash.new(data)
    end

    def url_helpers
      @url_helpers ||= Rails.application.routes.url_helpers
    end

    def context
      [
        "https://www.w3.org/ns/activitystreams",
        {
          bloblo: "#",
          "address": "bloblo:address",
          "location": "bloblo:location",
          "Tip": "as:Tip",
          "valueNuwei": "bloblo:valueNuwei",
          "message": "bloblo:message",
          "toMessage": "bloblo:toMessage",
          "transactionHash": "bloblo:transactionHash",
          "manuallyApprovesFollowers": "as:manuallyApprovesFollowers"
        }
      ]
    end

    def data
      {
        "@context" => context
      }.merge(object_data)
    end

    def person(account)
      ActivityPub::Person.new(account).object_data
    end
  end
end