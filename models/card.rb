# require 'pg'
def all_cards_for_user(id)
    all_cards = run_sql("SELECT * FROM cards WHERE user_id = $1;",[ id ])
    all_cards
end


def create_card(name, image, workplace, job, met, relationship, skills, quality, notes, user_id) 
    run_sql("INSERT INTO cards (name, image, workplace, job, met, relationship, skills, quality, notes, user_id) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10);",[name, image, workplace, job, met, relationship, skills, quality, notes, user_id])
end

def get_card_by_id(id)
    card = run_sql("SELECT * FROM cards WHERE id = $1",[ id ])
    card[0]
end

def edit_card(id, name, image, workplace, job, met, relationship, skills, quality, notes)
    run_sql("UPDATE cards SET name=$1, image=$2, workplace=$3, job=$4, met=$5, relationship=$6, skills=$7, quality=$8, notes=$10 WHERE id=$11;",[
        name, image, workplace, job, met, relationship, skills, quality, notes, id
    ])
end

def delete_cards(id)
    run_sql("DELETE FROM cards WHERE id = $1;",[ id ])
end