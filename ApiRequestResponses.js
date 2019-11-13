
// create user
url: '/api/v1/users'
method: 'POST'
params: {
  user: {
    username: 'a_username'
    email: 'an@email.com'
    password: 'password'
  }
}
//_______________________
response: { success: true }
response: { failure: { message: 'bad things' } }
//___________________________

// sign in user
url: '/api/v1/auth'
method: 'POST'
params: {
  user: {
    email: 'an@email.com'
    password: 'password'
  }
}
//_______________________
response: { success: { token: '813482382348', username: 'a_username' } }
response: { failure: { message: 'bad things' } }
//___________________________

// all posts
url: '/api/v1/posts'
method: 'GET'
// OPTIONAL PARAMS
params: {
  wall_id: 1
}
// _____________________

response: [
  { 
    id: 1,
    message: "Things",
    created_at: "2019-11-13T10:40:45.118Z",
    updated_at: "2019-11-13T10:40:45.118Z",
    user_id: 2,
    wall_id: 2,
    user: {
      id: 2, 
      username:"bob" 
    },
    get_likes:[
      {"id":1}
      ]
    },
    comments: [
      { id: 1, 
        message: "stuff",
        created_at: "2019-11-13T10:41:08.066Z",
        updated_at: "2019-11-13T10:41:08.066Z", 
        user_id: 2,
        user: { id: 2,
                username: "bob"
              },
        get_likes: [
          { id: 2 }
        ]
      }
    ]
  ]
//____________________________

// create post
url: '/api/v1/posts'
method: 'POST'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
params: {
  post: {
    message: 'A Post bruh'
    wall_id: 1
  }
}

//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// edit post
url: '/api/v1/posts/1'
method: 'PATCH'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
params: {
  post: {
    message: 'A Post bruh'
  }
}

//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// delete post
url: '/api/v1/posts/1'
method: 'DELETE'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// add comment
url: '/api/v1/posts/1/comments'
method: 'POST'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
params: {
  comment: {
    message: 'A Post bruh'
  }
}

//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// edit comment
url: '/api/v1/posts/1/comments/1'
method: 'PATCH'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
params: {
  comment: {
    message: 'A Post bruh'
  }
}

//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// delete comment
url: '/api/v1/posts/1/comments/1'
method: 'DELETE'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},

//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// Like a post
url: '/api/v1/posts/1/likes'
method: 'POST'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// Unlike a post
url: '/api/v1/posts/1/comments/1/likes'
method: 'DELETE'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// Like a Comment
url: '/api/v1/posts/1/comments/1/likes'
method: 'POST'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________

// Unlike a Comment
url: '/api/v1/posts/1/comments/1/likes'
method: 'DELETE'
headers: {
  "ACCEPT": "application/json",
  "Authorisation": '98239578239875239785239875'
},
//_______________________
response: { success: { } }
response: { failure: { message: 'bad things' } }
//___________________________