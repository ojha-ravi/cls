import * as promise from 'bluebird';

const options = {
  promiseLib: promise
};

const pgp = require('pg-promise')(options);

const connectionString = 'postgres://localhost:5432/consumerlawyer';
const db = pgp(connectionString);

export const getAllUser = (req, res, next) => {
  db
    .any('select * from login_detail')
    .then(data => {
      res.status(200).json({
        status: 'success',
        data,
        message: 'Retrieved ALL Users'
      });
    })
    .catch(err => next(err));
};

export const getSingleUser = (req, res, next) => {
  const pupID = parseInt(req.params.id, 10);
  db
    .one('select * from login_detail where id = $1', pupID)
    .then(data => {
      res.status(200).json({
        status: 'success',
        data,
        message: 'Retrieved ONE User'
      });
    })
    .catch(err => next(err));
};

export const createUser = (req, res, next) => {
  req.body.age = parseInt(req.body.age, 10);
  /* eslint-disable no-template-curly-in-string, no-useless-concat */
  db
    .none('insert into login_detail(name, breed, age, sex)' + 'values(${name}, ${age}, ${sex})', req.body)
    .then(() => {
      res.status(200).json({
        status: 'success',
        message: 'Inserted one User'
      });
    })
    .catch(err => next(err));
  /* eslint-enable no-template-curly-in-string, no-useless-concat */
};

export const updateUser = (req, res, next) => {
  db
    .none('update login_detail set name=$1, age=$3, sex=$4 where id=$5', [
      req.body.name,
      req.body.breed,
      parseInt(req.body.age, 10),
      req.body.sex,
      parseInt(req.params.id, 10)
    ])
    .then(() => {
      res.status(200).json({
        status: 'success',
        message: 'Updated User'
      });
    })
    .catch(err => next(err));
};

export const removeUser = (req, res, next) => {
  const pupID = parseInt(req.params.id, 10);
  db
    .result('delete from login_detail where id = $1', pupID)
    .then(result => {
      res.status(200).json({
        status: 'success',
        message: `Removed ${result.rowCount} User`
      });
    })
    .catch(err => next(err));
};
