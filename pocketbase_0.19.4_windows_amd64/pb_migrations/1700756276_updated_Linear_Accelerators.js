/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("2cr9mgwuw1r88nv")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "j4sfkfhs",
    "name": "Bookings",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "atody5np5n7l41k",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("2cr9mgwuw1r88nv")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "j4sfkfhs",
    "name": "booking",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "atody5np5n7l41k",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
})
