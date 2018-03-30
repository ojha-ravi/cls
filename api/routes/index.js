import express from 'express';
import * as dbQueries from '../queries/queries';

const router = express.Router();

router.get('/api/users', dbQueries.getAllUser);
router.get('/api/users/:id', dbQueries.getSingleUser);
router.post('/api/users', dbQueries.createUser);
router.put('/api/users/:id', dbQueries.updateUser);
router.delete('/api/users/:id', dbQueries.removeUser);

export default router;