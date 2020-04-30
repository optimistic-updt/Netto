require 'pg'
require 'bcrypt'


def run_sql(sql, params)
    conn = PG.connect(ENV['DATABASE_URL'] || {dbname: 'netto'})
    records = conn.exec_params(sql,params)
    conn.close
 
    records
end


def create_user(email, password)
    pw_digest = BCrypt::Password.create(password)
    run_sql("INSERT INTO users (email, pw_digest) VALUES ($1, $2);",[ email, pw_digest ])
end


def get_user_by_id(id)
    user = run_sql("SELECT * FROM users WHERE id = $1;",[ id ])

    if user.count == 0
        nil
    else
        user[0]
    end
end


def get_user_by_email(email)
    user = run_sql("SELECT * FROM users WHERE email = $1;",[ email ])

    if user.count == 0
        nil
    else
        user[0]
    end
end