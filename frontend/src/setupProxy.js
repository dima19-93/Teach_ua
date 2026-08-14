const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function(app) {

  app.use('/club/dev/static', function(req, res) {
    res.redirect('https://unsplash.com');
  });


  app.use(
    '/dev',
    createProxyMiddleware({
      target: 'http://backend:8080',
      changeOrigin: true,
    })
  );
};

