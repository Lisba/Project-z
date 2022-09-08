import pool from '@libs/postgres';
import { Pool} from '@types/pg'
import UserService from '@services/users';
import DataHash from '@helpers/utils/dataHash';
import jwt from 'jsonwebtoken'
const Users = new UserService()

class Auth {
  pool: Pool
  constructor() {
      this.pool = pool
  }

  public async login(email: string, pass: string) {
    const user = await Users.findByEmail(email);
    if (!user) {
      throw new Error('Invalid credentials');
    }
    const isMatch = await DataHash.verify(user.password, pass);
    if (!isMatch) {
      throw new Error('Invalid credentials');
    }
    const { password, ...response } = user;

    const accessToken = this.signAccessToken({ user_id: user.id });

    await this.saveAccessTokenToDB(accessToken, user.id);
    
    return { 
      ...response,
      accessToken
    };
  }

  public signAccessToken(payload: object) {
    var token = jwt.sign(
      payload, 
      process.env.JWT_SECRET,
      {
        expiresIn: '2d',
      }
    );
    return token;
  }

  //TODO: Add logic for not accumulating expired tokens. Maybe delete old ones, or overwrite when creating new one?
  public async saveAccessTokenToDB(token: string, user_id: number) {
    const query = `INSERT INTO "accessToken" (
      token,
      user_id
    ) VALUES ($1, $2)`

    const values = [token, user_id];

    await this.pool.query(query,values);
  }
}

export default Auth