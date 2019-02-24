fetch('http://localhost:3000/user')
  .then(function(response) {
    return response.json();
  })
  .then(function(res) {
    console.log('res ', res);
  })
  .catch(function(error) {
    console.log('error ', error);
  });
