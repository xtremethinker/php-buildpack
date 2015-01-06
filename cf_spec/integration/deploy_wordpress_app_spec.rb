$: << 'cf_spec'
require 'cf_spec_helper'

describe 'CF PHP Buildpack' do
  subject(:app) { Machete.deploy_app(app_name) }
  let(:browser) { Machete::Browser.new(app) }

  after do
    # Machete::CF::DeleteApp.new.execute(app)
  end

  context 'deploying a wordpress app' do
    let(:app_name) { 'composer_wordpress' }
    let(:options) do
      {with_pg: true, database_name: 'wordpress'}
    end

    specify do
      expect(app).to be_running
    end
  end
end
