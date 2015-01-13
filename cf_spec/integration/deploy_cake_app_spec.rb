$: << 'cf_spec'
require 'cf_spec_helper'

describe 'CF PHP Buildpack' do
  subject(:app) { Machete.deploy_app(app_name, options) }
  let(:browser) { Machete::Browser.new(app) }

  after do
    Machete::CF::DeleteApp.new.execute(app)
  end

  context 'deploying a cake app' do
    let(:app_name) { 'cake_with_local_dependencies' }
    let(:options) do
      {
        with_pg: true,
        # start_command: 'app/Console/cake schema create -y ; ./start.sh'
        # start_command: "echo '******************'; pwd; app/Console/cake schema create -y; ./start.sh"


                    

        start_command: 'app/Console/cake schema create -y; $HOME/php/sbin/php-fpm -p "$HOME/php/etc" -y "$HOME/php/etc/php-fpm.conf" -c "$HOME/php/etc"; $HOME/.bp/bin/rewrite "$HOME/httpd/conf"; $HOME/httpd/bin/apachectl -f "$HOME/httpd/conf/httpd.conf" -k start -DFOREGROUND'
      }
    end

    specify do
      expect(app).to be_running

      browser.visit_path("/")
      expect(browser).to have_body 'CakePHP'
      expect(browser).not_to have_body 'Missing Database Table'

      assert_offline_mode_has_no_internet_traffic
    end
  end
end
