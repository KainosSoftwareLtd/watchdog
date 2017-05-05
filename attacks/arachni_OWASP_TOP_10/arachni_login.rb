browser.goto 'http://192.168.250.9:8080/login'

form = browser.form( id: 'loginform' )
form.text_field( name: 'username' ).set 'llclradmin@nonexistanttest.com'
form.text_field( name:'password' ).set 'password'
form.button( id:'btnSubmit' ).click

framework.options.session.check_url	= browser.url
framework.options.session.check_pattern = /Sign out/

# tests in .attack file need --plugin=login_script:script=arachni_login.rb appended to the exec call
# can't get this working as the path isn't recognised. Probably missing something obvious.