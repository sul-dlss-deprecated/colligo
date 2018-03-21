require 'rails_helper'

describe 'Annotations routing' do
  describe 'allow URIs as id' do
    it do
      expect(delete: '/annotations/https://www.example.com/1').to route_to(
        controller: 'annotot/annotations',
        action: 'destroy',
        format: :json,
        id: 'https://www.example.com/1'
      )
    end
  end
end
