login_url = 'http://192.168.250.9:8080/login'
=begin
browser.goto login_url

browser.text_field( name: 'username' ).set 'llclradmin@nonexistanttest.com'
browser.text_field( name:'password' ).set 'password'
browser.button( id:'btnSubmit' ).click

framework.options.session.check_url = browser.url
framework.options.session.check_pattern = /Sign out/
=end

#=begin
response = http.post( login_url,
                      parameters:     {
                          'username'   => 'llclradmin@nonexistanttest.com',
                          'password' => 'password'
                      },
                      mode:           :sync,
                      update_cookies: true,
                      content_type: 'application/x-www-form-urlencoded'
)
framework.options.session.check_url = to_absolute( response.headers.location, response.url ) #'http://192.168.250.9:8080/login'
framework.options.session.check_pattern = '/.*'
#=end