# require 'pg'
def all_cards_for_user(id)
    all_cards = run_sql("SELECT * FROM cards WHERE user_id = $1;",[ id ])
    all_cards
end

# CORRECT THIS ONE HAS THERE WILL BE A BREACH IN YOUR DATABASE

def search(parameter)
    sql = "SELECT * FROM cards 
            WHERE name LIKE '%#{parameter}%'
            OR workplace LIKE '%#{parameter}%'
            OR job LIKE '%#{parameter}%'
            OR met LIKE '%#{parameter}%'
            OR relationship LIKE '%#{parameter}%'
            OR skills LIKE '%#{parameter}%'
            OR quality LIKE '%#{parameter}%'
            ;"

    conn = PG.connect(dbname: 'netto')
    search_result = conn.exec(sql)
    conn.close

    # search_result = run_sql("SELECT * FROM cards WHERE name LIKE '%$1%';", [{ :value => parameter, :type => 0, :format => 0 }])

    search_result
end


def create_card(name, image, workplace, job, met, relationship, skills, quality, notes, user_id) 
    run_sql("INSERT INTO cards (name, image, workplace, job, met, relationship, skills, quality, notes, user_id) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10);",[name, image, workplace, job, met, relationship, skills, quality, notes, user_id])
end

def get_card_by_id(id)
    card = run_sql("SELECT * FROM cards WHERE id = $1",[ id ])
    card[0]
end

def edit_card(id, name, image, workplace, job, met, relationship, skills, quality, notes)
    run_sql("UPDATE cards SET name=$1, image=$2, workplace=$3, job=$4, met=$5, relationship=$6, skills=$7, quality=$8, notes=$9 WHERE id=$10;",[
        name, image, workplace, job, met, relationship, skills, quality, notes, id
    ])
end

def delete_card(id)
    run_sql("DELETE FROM cards WHERE id = $1;",[ id ])
end