browser.goto 'http://192.168.250.9:8080/login'

form = browser.form( id: 'loginform' )
form.text_field( name: 'username' ).set 'llclradmin@nonexistanttest.com'
form.text_field( name:'password' ).set 'password'
form.button( id:'btnSubmit' ).click

framework.options.session.check_url	= browser.url
framework.options.session.check_pattern = /Sign out/