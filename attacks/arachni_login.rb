# Documentation http://support.arachni-scanner.com/kb/general-use/logging-in-and-maintaining-a-valid-session

hostname = ''

username = ''
password = ''

login_url = hostname + ''

# With browser (slow)
=begin
browser.goto login_url

browser.text_field( name: 'username' ).set username
browser.text_field( name:'password' ).set password
browser.button( id:'btnSubmit' ).click

framework.options.session.check_url = browser.url
framework.options.session.check_pattern = /Sign out/
=end

# Without browser (fast)
=begin
response = http.post( login_url,
                      parameters:     {
                          'username'   => username,
                          'password' => password
                      },
                      mode:           :sync,
                      update_cookies: true,
                      content_type: 'application/x-www-form-urlencoded'
)
framework.options.session.check_url = to_absolute( response.headers.location, response.url )
framework.options.session.check_pattern = '/.*'
=end