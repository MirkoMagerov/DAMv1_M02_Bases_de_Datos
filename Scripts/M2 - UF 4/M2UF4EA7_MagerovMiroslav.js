// EX 2
// a)
db.people.find({"name" : {$regex : /n$/i}}, {email : 1, _id : 0})

// b)
db.people.find({
    $or: [
      { "tags": { $regex: /qui$/i } },
      { "tags": { $regex: /sunt$/i } }
    ]
  }).limit(8).pretty()

// c)
db.people.find({
    "friends.name" : {$regex : /serenity nelson/i}}).pretty()

// d)
db.people.countDocuments({
    $and : [{
    "registered": {
        $regex: /^200[1-9]|201[0-8]/}},
    {company : {$regex : /jam/i}}
]})

db.people.find({
    $and : [{
    "registered": {
        $regex: /^200[1-9]|201[0-8]/}},
    {company : {$regex : /jam/i}}
]}).count()

// e)
db.people.find({
    $and: [
        { tags: { $nin: ["tempor"] } },
        { tags: { $nin: ["nulla"] } }
    ]
}, { tags: 1, _id: 0 })

// f)
db.people.find({$and : 
    [{isActive : false}, 
     {friends : {$size : 3}}, 
     {gender : "female"}]})


// EX 3
// a)
db.people.aggregate([{$unwind : "$friends"},
                     {$project : {_id : 0,friendName: "$friends.name"}}])

// b)
db.people.aggregate([{$unwind : "$tags"},
                     {$group : {
                        _id : "$tags",
                        count : {$sum : 1}
                     }}])