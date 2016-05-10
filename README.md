[![Circle CI](https://circleci.com/gh/tagCincy/TAGitter/tree/master.svg?style=svg&circle-token=3807a3dde2591340c817b4bc46f3e084dafdbb78)](https://circleci.com/gh/tagCincy/TAGitter/tree/master)

# TAGitter

Twitter clone coding sample

To run (_standard Rails app_):

1. install Ruby 2.3.1 if not already installed
2. clone repo
3. `bundle`
4. `rake db:setup`
5. `rails s`

This is a 100% Service (API) application.  The endpoints can be tested by using tools like cURL or Postman.
 
Client side application in development:  https://github.com/tagCincy/TAGitter-client

API Instructions:

- Registration: `POST /api/v1/auth`
    - Required: `email`, `handle`, `password`, `password_confirmation`
    - Response: 
        - body: newly created user
        - headers: `access-token`, `token-type`, `uid`, `expiry` returned and used for future api calls
        
- Sign-in: `POST /api/v1/auth/sign_in`
    - Required: `email` or `handle` and `password`
    - Response: 
        - body: newly created user
        - headers: `access-token`, `token-type`, `uid`, `expiry` returned and used for future api calls
        
- Posts (and endpoints require `access-token`, `token-type`, `uid`, and `expiry` headers):
    - User's Feed: `GET /api/v1/authenticated/posts`
    - Specific Post: `GET /api/v1/authenticated/posts/:id`
    - Create Post: `POST /api/v1/authenticated/posts`
        - required: `body` (=< 144 characters)
    - Update Post: `PATCH /api/v1/authenticated/posts/:id`
        - required: new `body`
    - Delete Post: `DELETE /api/v1/authenticated/posts/:id`
    
    - Repost: `POST /api/v1/authenticated/posts/:id/repost`
    - Favorite: `POST /api/v1/authenticated/posts/:id/favorite`
    - Unfavor: `DELETE /api/v1/authenticated/posts/:id/unfavorite`
    
- Users (and endpoints require `access-token`, `token-type`, `uid`, and `expiry` headers):
    - View User: `GET /api/v1/authenticated/users/:id`
    - View Owen User: `GET /api/v1/authenticated/users/me`
    - Update Own User: `PATCH /api/v1/authenticated/users/me`
    - Follow User: `POST /api/v1/authenticated/users/:id/follow`
    - Unfollow User: `POST /api/v1/authenticated/users/:id/unfollow`