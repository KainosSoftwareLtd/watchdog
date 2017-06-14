browser.goto 'http://192.168.250.9:8080/login'

browser.text_field( name: 'username' ).set 'llclradmin@nonexistanttest.com'
browser.text_field( name:'password' ).set 'password'
browser.button( id:'btnSubmit' ).click

framework.options.session.check_url = browser.url
framework.options.session.check_pattern = /Sign out/