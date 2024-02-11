-- EX 1
use catalogo
use productos

db.productos.insertOne({"name" : "MacBook Pro"})
db.productos.insertOne({"name" : "MacBook Air"})
db.productos.insertOne({"name" : "MacBook"})

show dbs

show collections

exit

mongo catalogo

-- EX 2
db.productos.find()

db.productos.find({"name" : "MacBook Air"})

-- EX 3
var productsCursor = db.productos.find()

productsCursor.hasNext() -- true
productsCursor.next()

productsCursor.hasNext() -- true
productsCursor.next()

productsCursor.hasNext() -- true
productsCursor.next()

productsCursor.hasNext() -- false

-- EX 4
db.productos.insertMany([{"name" : "iPhone 8"},
                         {"name" : "iPhone 6s"},
                         {"name" : "iPhone X"},
                         {"name" : "iPhoneSE"},
                         {"name" : "iPhone7"}])

db.productos.find()

db.productos.find({"name" : "iPhone7"})

db.productos.find({"name" : "MacBook"})

-- EX 5
db.productos.drop()

db.dropDatabase()

use catalogo
b.createCollection("productos")

db.productos.insertMany([{"name": "iPhone 8"},
                         {"name": "MacBook Pro"},
                         {"name": "iPhone 6s"},
                         {"name": "MacBook Air"},
                         {"name": "iPhone X"},
                         {"name": "iPhone SE"},
                         {"name": "MacBook"},
                         {"name": "iPhone 7"}])

db.productos.find({"name" : "iPhone X"})

-- EX 6
-- Estando en la base de datos catalogo
db.productos.drop()
db.dropDatabase()

-- Fuera del cliente mongo
mongoimport --db itb --collection products --drop --file ./Baixades/products.json

mongo itb

db.products.find()

db.products.find().pretty()

db.products.find({"price" : 329})

db.products.find({"stock" : 100})

db.products.find({"name" : "Apple Watch Nike+"})

-- EX 7
db.products.find({"name" : 1, "price" : 1})

db.products.find({"categories" : "macbook", "categories" : "notebook"})

db.products.find({"categories" : "watch"})

-- EX 8
db.products.find({"price" : 2399}, {"name" : 1})

db.products.find({"categories" : "iphone"}, {"stock" : 0, "picture" : 0})

db.products.find({"price" : 2399}, {"name" : 1, "_id" : 0})

db.products.find({"categories" : "iphone"}, {"stock" : 0, "picture" : 0, "_id" : 0})

-- EX 9
db.products.find({"price" : { $gt: 2000}})

db.products.find({"price" : { $lt: 500}})

db.products.find({"price" : { $lte : 500}})

db.products.find({"price" : { $lte : 1000, $gte : 500}})

db.products.find({"price" : { $in : [399, 699, 1299]}})

-- EX 10
db.products.find({ $and : [{"stock" : 200}, 
                           {"categories" : "iphone"}]})

db.products.find({ $or : [{"price" : 329}, 
                          {"categories" : "tv"}]})

-- EX 11
db.products.updateOne(
{"name" : "Mac mini"},
{$set : {"stock" : 50}})

db.products.updateOne(
{"name" : "iPhone X"},
{$set : {"prime" : true}})

db.products.find({"name" : "Mac mini"}) -- Stock = 50

db.products.find({"name" : "iPhone X"}) -- Agregada la propiedad prime en true.

-- EX 12
db.products.updateOne(
{"name" : "iPad Pro"},
{$push : {"categories" : "prime"}})

db.products.updateOne(
{"name" : "iPad Pro"},
{$pop : {"categories" : 1}})

db.products.updateOne(
{"name" : "iPhone SE"},
{$pop : {"categories" : -1}})

db.products.updateMany(
{"price" : {$gte : 2000}},
{$push : {"categories" : "expensive"}})

-- EX 13
db.products.deleteMany({"categories" : "tv"})

db.products.deleteOne({"name" : "Apple Watch Series 1"})

db.products.find({"name" : "Mac mini"}, {"_id" : 1})

db.products.deleteOne({"_id" : ObjectId("65c79cd101b34dc9fda2a398")})

-- EX 14
mongoimport --db itb --collection products --drop --file ./Baixades/products.json

db.products.find()

-- EX 15
db.products.find({}, {_id : 0}).sort({"price" : 1})

db.products.find({}, {_id : 0}).sort({"price" : -1})

db.products.find({}, {_id : 0}).sort({"stock" : 1})

db.products.find({}, {_id : 0}).sort({"stock" : -1})

db.products.find({}, {_id : 0}).sort({"name" : 1})

db.products.find({}, {_id : 0}).sort({"name" : -1})

-- EX 16
db.products.find({}, {"name" : 1, _id : 0}).limit(2)

db.products.find({}, {"name" : 1, _id : 0}).limit(5).sort({"name" : 1})

db.products.find({}, {"name" : 1, _id : 0}).limit(5).sort({"name" : -1})

-- EX 17
db.products.find().skip(0).limit(5).pretty()