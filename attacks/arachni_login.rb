response = http.post( 'http://0.0.0.0:8080/login',
                      parameters:     {
                          'username-input'   => 'llclradmin@nonexistanttest.com',
                          'password-input' => 'password'
                      },
                      mode:           :sync,
                      update_cookies: true
)

framework.options.session.check_url	= browser.url
framework.options.session.check_pattern = /Sign out/