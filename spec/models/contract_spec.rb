require 'rails_helper'

RSpec.describe Contract, type: :model do
  it 'finds the BloBlo contract', :end_to_end do
    expect(Contract.find_by(name: :bloblo)).to eql(Contract.bloblo)
  end
end
