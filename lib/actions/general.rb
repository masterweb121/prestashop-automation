module PrestaShopAutomation
	module GeneralActions
		def login_to_back_office
			visit @back_office_url
			fill_in "email", :with => @admin_email
			fill_in "passwd", :with => @admin_password
			click_label_for 'stay_logged_in'
			click_button_named 'submitLogin', :first => true
			expect_to have_selector('#header_logout', :visible => false)
			@logged_in_to_back_office_as = {
				email: @admin_email,
				password: @admin_password
			}
		end

		def goto_back_office
			visit @back_office_url
		end

		def goto_front_office
			visit @front_office_url
		end

		def logout_of_back_office
			visit @back_office_url
			click '#employee_infos a'
			click '#header_logout'
			expect_to have_selector('button[name="submitLogin"]')
			@logged_in_to_back_office_as = nil
		end

		def login_to_front_office
			visit @front_office_url
			click 'a.login'
			within '#login_form' do
				fill_in 'email', :with => @default_customer_email
				fill_in 'passwd', :with => @default_customer_password
			end
			click '#SubmitLogin'
			expect_to have_selector('p.info-account')
			@logged_in_to_front_office_as = {
				email: @default_customer_email,
				password: @default_customer_password
			}
		end

		def logout_of_front_office
			visit @front_office_url
			click 'a.logout'
			expect_to have_selector 'a.login'
			@logged_in_to_front_office_as = nil
		end

		def goto_admin_tab tab
			links = Hash[all('ul.menu a', :visible => false).to_a.keep_if do |a|
				a['href'] =~ /\?controller=/
			end.map do |a|
				[a['href'][/\?controller=(.+?)\b/, 1], a['href']]
			end]
			expect(links[tab]).not_to eq nil
			visit links[tab]
			expect(current_url).to match /\bcontroller=#{tab}\b/
		end
	end
end
