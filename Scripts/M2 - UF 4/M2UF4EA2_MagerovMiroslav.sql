// 1
db.students.find({gender : "H"})

// 2
db.students.find({gender : "M"})

// 3
db.students.find({birth_year : 1993})

// 4
db.students.find({$and : [{gender : "H"}, {birth_year : 1993}]})

// 5
db.students.find({$and : [{birth_year : {$gte : 1990}},
                          {birth_year : {$lte : 1999}}]})

// 6
db.students.find({$and : [{birth_year : {$lt : 1990}},
                          {gender : "H"}]})

// 7
db.students.find({$and : [{birth_year : {$lt : 1990}},
                          {gender : "M"}]})

// 8
// Es lo mismo que el 5

// 9
db.students.find({$and : [{birth_year : {$gte : 1980}},
                          {birth_year : {$lte : 1989}},
                          {gender : "H"}]})

// 10
db.students.find({$and : [{birth_year : {$gte : 1980}},
                          {birth_year : {$lte : 1989}},
                          {gender : "M"}]})

// 11
db.students.find({birth_year : {$ne : 1985}})

// 12
db.students.find({birth_year : {$in : [1990, 1980, 1970]}})

// 13
db.students.find({birth_year : {$not : {$in : [1990, 1980, 1970]}}})

// 14
db.students.find({birth_year : {$mod : [2,0]}})

// 15
db.students.find({birth_year : {$mod : [10,0]}})

// 16
db.students.find({phone_aux : {$ne : ""}})

// 17
db.students.find({lastname2 : {$ne : ""}})

// 18
db.students.find({$and : [{phone_aux : {$ne : ""}},
                          {lastname2 : {$ne : ""}}]})

// 19
db.students.find({email : {$regex : /net$/i}})

// 20
db.students.find({$or : [{firstname : {$regex : /^a/i}},
                         {firstname : {$regex : /^e/i}},
                         {firstname : {$regex : /^i/i}},
                         {firstname : {$regex : /^o/i}},
                         {firstname : {$regex : /^u/i}},]})

// 21
db.students.find({$expr : {$gt : [{$strLenCP : "$firstname"}, 13]}})

// 22
db.students.find({firstname : {$regex : /(?:[aeiou]{3,})/i}})

// 23
db.students.find({dni : {$regex : /^[a-zA-Z]/}})

// 24
db.students.find({$and : [{dni : {$regex : /^[a-zA-Z]/}},
                          {dni : {$regex : /[a-zA-Z]$/}}]})

// 25
db.students.find({phone : {$regex : /^622/}})