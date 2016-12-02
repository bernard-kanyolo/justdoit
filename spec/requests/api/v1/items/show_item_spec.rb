require 'rails_helper'

RSpec.describe 'Show a bucketlists item', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create(:bucketlist, user: user) }
  let!(:bucket_id) { bucket.id }
  let!(:item) { create(:item, bucketlist: bucket) }
  let(:id) { item.id }
  let(:header) { valid_headers(user) }

  let!(:request) { get "/bucketlists/#{bucket_id}/items/#{id}", params: {}, headers: header }
  subject { response }

  context 'when bucketlist id exists for that user' do
    context 'when bucketlist item id exists' do
      it_behaves_like('a http response', 200)

      it 'returns the queried bucketlist item' do
        expect(json['name']).to eq item.name
        expect(json['id']).to eq item.id
      end
    end
  end

  include_context('when resource id does not exist for that user', 'item')
  include_context(
    'when resource id does not exist for that user',
    'bucketlist',
    bucket_id: -1)
  include_context 'when authorization token is not included'
end
