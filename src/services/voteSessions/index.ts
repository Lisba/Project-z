import { postgresPool } from '@libs';
import Boom from '@hapi/boom';
import { Pool } from 'pg';

const pool: Pool = postgresPool;

export const findAllVoteSessions = async () => {
  try {
    const query = 'SELECT created_at, title, description, user_id FROM "voteSession"';
    const result = await pool.query(query);
    return result.rows;
  } catch (error) {
    throw error;
  }
};

//TODO: cambiar user_id por facilitator
export const createVoteSession = async (title: string, description: string, user_id: number) => {
  try {
    if (!title) {
      throw Boom.badRequest('missing title field');
    }
    if (!description) {
      throw Boom.badRequest('missing description field');
    }
    if (!user_id) {
      throw Boom.badRequest('missing user_id field');
    }
    
    const values = [title, description, user_id];
    const query = `INSERT INTO "voteSession" (title, description, user_id) VALUES ($1, $2, $3)`;
    await pool.query(query, values);
  } catch (error) {
    throw error;
  }
};

export const findVoteSessionById = async (id: number) => {
  try {
    const query = 'SELECT title, description, user_id FROM "voteSession" WHERE id = $1';
    const values = [id];
    const result = await pool.query(query, values);
    if (result.rows.length < 1) {
      throw Boom.notFound('Vote session not found!');
    }
    return result.rows[0];
  } catch (error) {
    throw error;
  }

}

//TODO: crear funcion para borrar y editar una vote session