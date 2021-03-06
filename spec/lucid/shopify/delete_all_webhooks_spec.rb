# frozen_string_literal: true

require_relative 'register_webhooks_shared_context'

module Lucid
  module Shopify
    RSpec.describe DeleteAllWebhooks do
      let(:client) { instance_double('Client') }
      let(:delete_webhook) { instance_double('DeleteWebhook') }

      subject(:delete_all_webhooks) do
        DeleteAllWebhooks.new(
          client: client,
          delete_webhook: delete_webhook
        )
      end

      include_context 'register webhooks'

      let(:data) { {'webhooks' => webhooks['shopify']} }

      it 'deletes any existing webhooks' do
        expect(client).to receive(:get).and_return(data)

        webhooks['shopify'].each do |webhook|
          expect(delete_webhook).to receive(:call).with(credentials, webhook['id'])
        end

        delete_all_webhooks.(credentials)
      end
    end
  end
end
