class SyncChainJob < ApplicationJob
  queue_as :default

  def perform
    BloBloChain::Sync.sync!
    SyncChainJob.set(wait: 1.minute).perform_later
  end
end
