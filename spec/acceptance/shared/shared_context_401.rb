RSpec.shared_context '401' do
  example_request 'without sign in' do
    expect(status).to eq(401)
  end
end