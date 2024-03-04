// EX 1
// a)
db.people.deleteMany({name : /berl/i})

// b)
db.people.updateMany({}, {$unset : {latitude : ""}})

// c)
db.people.updateOne({name : "Aubrey Calhoun"}, {$pull : {tags : "enim"}})

// d)
db.people.updateOne({name : "Caroline Webster"}, {$pop : {tags : -1}})

// EX 2
// a)
db.people.aggregate([
    {$project : {
            _id : 0,
            name : 1,
            tagsCount : {$size : "$tags"}}},
    {$match : {tagsCount : {$gte : 7}}}])