import express from 'express';
import * as dbQueries from '../queries/queries';

const router = express.Router();

router.get('/api/users', dbQueries.getAllUser);
router.get('/api/login', dbQueries.loginUser);
router.get('/api/profile', dbQueries.getUserProfile);

router.post('/api/document/upload', dbQueries.documentUpload);
router.delete('/api/document/delete', dbQueries.documentDelete);

router.get('/api/complain/index', dbQueries.getAllComplain);
router.post('/api/complain/save', dbQueries.saveComplain);
router.post('/api/complain/update', dbQueries.saveComplain);

router.post('/api/users', dbQueries.createUser);
router.put('/api/users/:id', dbQueries.updateUser);
router.delete('/api/users/:id', dbQueries.removeUser);

export default router;
