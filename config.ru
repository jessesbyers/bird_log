require './config/environment'

use Rack::MethodOverride
use BirdsController
use SightingsController
use UsersController
run ApplicationController
