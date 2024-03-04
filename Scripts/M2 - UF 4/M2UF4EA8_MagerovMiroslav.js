// EX 1
// a)
db.people.updateMany({address : /berkeley/i}, {$set : {longitute : 1}})

// b)
db.people.updateOne({name : "Bella Carrington"}, {$set : {foot : null}})

// c)
db.people.updateOne({name : "Julia Young"}, {$push : {friends : {"id" : 1, "name" : "Trinity Ford"}}})

// d)
db.people.updateOne({name : "Ava Miers"}, {$set : {"tags.1" : "sunt"}})

// EX 2
// a)
db.people.aggregate([{$group : {
    _id : {genere : "$gender"},
    media : {$avg : "$age"}
}}])