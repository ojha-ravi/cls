import express from 'express';
import multer from 'multer';
import * as dbQueries from '../queries/queries';

let upload = multer({ dest: 'uploads/' });

const router = express.Router();

const storage = multer.diskStorage({
  destination: '../assets',
  filename(req, file, cb) {
    cb(null, `${new Date()}-${file.originalname}`);
  }
});

upload = multer({ storage });

router.get('/api/users', dbQueries.getAllUser);
router.get('/api/login', dbQueries.loginUser);
router.get('/api/profile', dbQueries.getUserProfile);
router.post('/api/complain/save', dbQueries.saveComplain);
router.post('/api/users', dbQueries.createUser);
router.put('/api/users/:id', dbQueries.updateUser);
router.delete('/api/users/:id', dbQueries.removeUser);

export default router;
