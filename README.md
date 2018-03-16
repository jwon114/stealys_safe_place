# Rick and Morty themed Shopping App.

Project requirements were to build an app using Ruby Sinatra as a back-end and a PostGreSQL database. My idea was to build a shop where users can create logins and purchase items that are available in stock. Database transactions occur when inventory is purchased and user carts are updated. Product ratings and reviews can be given by only registered users.

## Tech Used

- Ruby Sinatra
- Active Record
- bcrypt
- HTML 
- CSS
- jQuery

## Deployment

Heroku Deployment URL
https://stealys-safe-place.herokuapp.com/

A Rake file is executed daily by Heroku Scheduler to update inventory stock when it runs out.

## Future Improvements

- Handling multiple users accessing the same inventory resource. At the moment it is on a first come first serve basis.