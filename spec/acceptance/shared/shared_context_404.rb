RSpec.shared_context '404' do

  let(:id) {id}

  example 'not found' do
    do_request

    expect(status).to eq(404)
  end
end