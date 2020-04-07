require File.expand_path('../config/environment', __FILE__)

use Rack::Static, root: 'app', :urls => ['/assets']
run App
