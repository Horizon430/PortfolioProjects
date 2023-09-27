import express from 'express';
import { createUser,getUsers, getUser, deleteUser, updateUser} from '../conrollers/users.js';


const router = express.Router();

let users = [];


//all routes in here are starting with /users
router.get('/', getUser);

router.post('/', createUser);

// /users/2 => req.params {id:2}
router.get('/:id', getUsers);

router.delete('/:id', deleteUser);

router.patch('/:id', updateUser);

export default router;
