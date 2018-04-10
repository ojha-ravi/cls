import express from 'express';
import path from 'path';
import logger from 'morgan';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import fileUpload from 'express-fileupload';
import routes from './api/routes/index';

const app = express();

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Add headers
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:9090');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'Content-Type,X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5,  Date, X-Api-Version, X-File-Name'
  );
  res.setHeader('Access-Control-Allow-Credentials', true);
  next();
});

app.use(fileUpload());

app.use(express.static(`${__dirname}/assets`));

app.use('/', routes);

// catch 404 and forward to error handler
app.use((req, res, next) => {
  const err = new Error('Not Found');
  err.status = 404;
  next(err);
});

if (app.get('env') === 'development') {
  // eslint-disable-next-line no-unused-vars
  app.use((err, req, res, next) => {
    res.status(err.code || 500).json({
      status: 'error',
      message: err
    });
  });
}
// eslint-disable-next-line no-unused-vars
app.use((err, req, res, next) => {
  res.status(err.status || 500).json({
    status: 'error',
    message: err.message
  });
});

export default app;
