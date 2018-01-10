#require 'rubygems'
require 'capybara'
#require 'capybara/dsl'

#Capybara.run_server = false
Capybara.current_driver = :selenium
#Capybara.app_host = 'http://www.google.com'
Capybara.default_selector = :xpath
session = Capybara::Session.new(:selenium)

i = 0
names_used = []
while i < 1
  name = ['a'..'z','A'..'Z'].map{ |range| range.to_a }.flatten
  name = (0...5).map{ name[ rand(name.size) ] }.join
  session.visit('https://dev.by/registration')
  session.fill_in('user_username', :with => name)
  session.fill_in('user_email',:with => name +'@mailinator.com')
  session.fill_in('user_password',:with => '123456')
  session.fill_in('user_password_confirmation',:with => '123456')
  session.check('user_agreement')
  session.click_on(class: 'btn blue submit')
  session.visit('https://www.mailinator.com/')
  session.fill_in('inboxfield', :with => name)
  session.click_button('Go!')
  sleep 5
  session.find(:xpath, '//li[contains(., "Dev.by")]').click
  sleep 2
  session.within_frame 'msg_body' do
    session.first(:css, 'a').click
  end
  sleep 5
  i += 1
  names_used << name
end
puts names_used

