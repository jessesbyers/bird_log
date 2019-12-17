Specs:

 X Use Sinatra to build the app
      # Done.

 X Use ActiveRecord for storing information in a database
      # Done.

 X Include more than one model class (e.g. User, Post, Category)
      # Users model
      # Sightings model
      # Birds model

 X Include at least one has_many relationship on your User model (e.g. User has_many Posts)
      # Users have many Sightings
      # Users have many Birds through Sightings
      # Birds have many Sightings
      # Birds have many Users through Sightings

 X Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
      # Sighting belongs to a User
      # Sighting belongs to a Bird

 X Include user accounts with unique login attribute (username or email)
      # Username and Email address are validated for uniqueness at account signup.
      # User logs in with Username and Password for each session.

 X Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
      # User can create, view, edit and delete their own sightings.
      # User can view only a snapshot of other users' birds and sightings.

 X Ensure that users can't modify content created by other users
      # Users can only link into the sightings detail pages of their own sightings.

 X Include user input validations
      # Username and password are validated.
      # Bird instances cannot be created without a valid url from the Audubon Online Bird Guide.

 X BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
      # Backup error messages are built into page views in case routes become disabled, or user accesses a route in an unexpected way.


 X Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
      # Done.

Confirm
 X You have a large number of small Git commits
 X Your commit messages are meaningful
 X You made the changes in a commit that relate to the commit message
 X You don't include changes in a commit that aren't related to the commit message
