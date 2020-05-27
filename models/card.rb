
def all_cards_for_user(id)
    all_cards = run_sql("SELECT * FROM cards WHERE user_id = $1;",[ id ])
    all_cards
end

def search(parameter)
    sql = "SELECT * FROM cards 
            WHERE name ILIKE '%#{parameter}%'
            OR workplace ILIKE '%#{parameter}%'
            OR job ILIKE '%#{parameter}%'
            OR met ILIKE '%#{parameter}%'
            OR skills ILIKE '%#{parameter}%'
            OR quality ILIKE '%#{parameter}%'
            ORDER BY name
            ;"

    conn = PG.connect(dbname: 'netto')
    search_result = conn.exec(sql)
    conn.close
    # search_result = run_sql("SELECT * FROM cards WHERE name ILIKE $1;", [ %parameter% ])
    search_result
end

def get_card_by_name(name)
    card = run_sql("SELECT * FROM cards WHERE name = $1",[ name ])
    
    if card.count == 0
        nil
    else
        card[0]
    end
end

def create_card(name, image, workplace, job, met, dependant, skills, quality, notes, user_id) 

    card = get_card_by_name(dependant)
    source = card["id"] unless card == nil

    # if card
    #     source = card["id"]
    # end

    run_sql("INSERT INTO cards (name, image, workplace, job, met, source, skills, quality, notes, user_id) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10);",[name.downcase, 
        image, 
        workplace.downcase, 
        job.downcase, 
        met.downcase, 
        source, 
        skills.downcase, 
        quality.downcase, 
        notes.downcase, user_id])
end

def get_card_by_id(id)
    card = run_sql("SELECT * FROM cards WHERE id = $1",[ id ])
    card[0]
end

def edit_card(id, name, image, workplace, job, met, dependant, skills, quality, notes)
    card = get_card_by_name(dependant)
    source = card["id"] unless card == nil

    run_sql("UPDATE cards SET name=$1, image=$2, workplace=$3, job=$4, met=$5, source=$6, skills=$7, quality=$8, notes=$9 WHERE id=$10;",[
        name.downcase, image, workplace.downcase, job.downcase, met.downcase, source, skills.downcase, quality.downcase, notes.downcase, id
    ])
end

def delete_card(id)
    run_sql("DELETE FROM cards WHERE id = $1;",[ id ])
end


def get_targets(id)
    cards = run_sql("SELECT * FROM cards WHERE source = $1;",[ id ])
    cards
end