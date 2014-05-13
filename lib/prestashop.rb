require 'rspec'
require 'rspec-expectations'
require 'capybara'
require 'capybara/rspec'

require_relative 'actions/general.rb'
require_relative 'helpers/general.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

module PrestaShopAutomation
	class PrestaShop < Capybara::Session

		include PrestaShopAutomation::GeneralHelpers
		include PrestaShopAutomation::GeneralActions
		include Capybara::RSpecMatchers

		def initialize options

			@front_office_url = options[:front_office_url]
			@back_office_url  = options[:back_office_url]
			@admin_email = options[:admin_email] or 'pub@prestashop.com'
			@admin_password = options[:admin_password] or '123456789'
			@default_customer_email = options[:default_customer_email] or 'pub@prestashop.com'
			@default_customer_password = options[:default_customer_password] or '123456789'
			@database_user = options[:database_user] or 'root'
			@database_password = options[:database_password] or ''
			@database_name = options[:database_name]
			@database_prefix = options[:database_prefix] or 'ps_'
			@database_port = options[:database_port] or '3306'
			@database_host = options[:database_host]
			@version = options[:version]

			super :selenium
		end

	end
end
